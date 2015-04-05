class MeetingPlace
  constructor:
    (@name,@address,@placeid,@lng,@lat,@radius) ->

Session.set "poslat", 0
Session.set "poslng", 0
Session.set "meetingplaces", [
  new MeetingPlace "Place A", "Up in here Ave, CA", 10, 60, 0
  new MeetingPlace "Place B", "Up in there Ave, CA", 20, 60, 0
  new MeetingPlace "Place C", "Everywhere Ave, CA", 30, 60, 0

]

Template.meetingplacesitems.helpers
  meetingplacesvar: -> Session.get "meetingplaces"
    
Template.map.helpers
  placemapOptions: ->
    if GoogleMaps.loaded()
      lat = Session.get "poslat"
      lng = Session.get "poslng"
      center: new google.maps.LatLng(lat, lng)
      zoom: 15
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControlOptions:
        style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
      zoomControlOptions:
        position: google.maps.ControlPosition.RIGHT_BOTTOM
      streetViewControlOptions:
        position: google.maps.ControlPosition.RIGHT_BOTTOM
      panControlOptions:
        position: google.maps.ControlPosition.LEFT_BOTTOM

Template.map.rendered = ->
    setPos = (lat, lng) ->
      Session.set "poslat", lat
      Session.set "poslng", lng

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (pos) ->
        setPos pos.coords.latitude, pos.coords.longitude
        , -> setPos 60, 105 # 'Error: The Geolocation service failed.'
    else setPos 60, 105     # Browser doesn't support Geolocation

Template.map.onCreated ->
  GoogleMaps.ready 'placemap', (mapobj)->
    map = mapobj.instance
    drawMap = (lat, lng, cont) ->
      options =
        map: map
        position: new google.maps.LatLng(lat, lng)
        content: cont
      infowindow = new google.maps.InfoWindow(options)
      map.setCenter options.position
    
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (pos) ->
        drawMap pos.coords.latitude, pos.coords.longitude, "Location found using HTML5."
          , -> drawMap 60, 105, "Error: The Geolocation service failed."
    else drawMap 60, 105, "Error: Your browser doesn't support geolocation."

    input = (document.getElementById("pac-input"))
    types = document.getElementById("type-selector")
    map.controls[google.maps.ControlPosition.TOP_LEFT].push input
    map.controls[google.maps.ControlPosition.LEFT_TOP].push types
    autocomplete = new google.maps.places.Autocomplete(input)
    autocomplete.bindTo "bounds", map
    infowindow = new google.maps.InfoWindow()
    marker = new google.maps.Marker(
      map: map
      anchorPoint: new google.maps.Point(0, -29)
    )
    google.maps.event.addListener autocomplete, "place_changed", ->
      infowindow.close()
      marker.setVisible false
      place = autocomplete.getPlace()
      return  unless place.geometry
      if place.geometry.viewport
        map.fitBounds place.geometry.viewport
      else
        map.setCenter place.geometry.location
        map.setZoom 17
      marker.setIcon (
        url: place.icon
        size: new google.maps.Size(71, 71)
        origin: new google.maps.Point(0, 0)
        anchor: new google.maps.Point(17, 34)
        scaledSize: new google.maps.Size(35, 35)
      )
      marker.setPosition place.geometry.location
      marker.setVisible true
      address = ""
      address = [ (place.address_components[0] and place.address_components[0].short_name or ""), (place.address_components[1] and place.address_components[1].short_name or ""), (place.address_components[2] and place.address_components[2].short_name or "") ].join(" ")  if place.address_components
      infowindow.setContent "<div><strong>" + place.name + "</strong><br>" + address
      infowindow.open map, marker
      
    setupClickListener = (id, types) ->
      radioButton = document.getElementById(id)
      google.maps.event.addDomListener radioButton, "click", ->
        autocomplete.setTypes types


    setupClickListener "changetype-all", []
    setupClickListener "changetype-address", [ "address" ]
    setupClickListener "changetype-establishment", [ "establishment" ]
    setupClickListener "changetype-geocode", [ "geocode" ]

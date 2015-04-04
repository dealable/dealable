Meteor.subscribe "orders"
#Meteor.subscribe "users"
# set the user's timezone
#
Session.set "poslat", 0
Session.set "poslng", 0

Template.sellers.helpers
  listsellers: -> Orders.find({direction: "sell"})
Template.buyers.helpers
  listbuyers: -> Orders.find({direction: "buy"})
Template.traded.helpers
  listtransactions: -> Orders.find()

Template.trade.onCreated ->
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
    console.log "google.maps", google.maps
    map.controls[google.maps.ControlPosition.TOP_LEFT].push input
    console.log "google.mapsx", google.maps.ControlPosition
#    autocomplete = new google.maps.places.Autocomplete(input)
#    autocomplete.bindTo "bounds", map
#    infowindow = new google.maps.InfoWindow()
#    marker = new google.maps.Marker(
#      map: map
#      anchorPoint: new google.maps.Point(0, -29)
#    )
#    google.maps.event.addListener autocomplete, "place_changed", ->
#      infowindow.close()
#      marker.setVisible false
#      place = autocomplete.getPlace()
#      return  unless place.geometry
#      if place.geometry.viewport
#        map.fitBounds place.geometry.viewport
#      else
#        map.setCenter place.geometry.location
#        map.setZoom 17
#      marker.setIcon (
#        url: place.icon
#        size: new google.maps.Size(71, 71)
#        origin: new google.maps.Point(0, 0)
#        anchor: new google.maps.Point(17, 34)
#        scaledSize: new google.maps.Size(35, 35)
#      )
#      marker.setPosition place.geometry.location
#      marker.setVisible true
#      address = ""
#      address = [ (place.address_components[0] and place.address_components[0].short_name or ""), (place.address_components[1] and place.address_components[1].short_name or ""), (place.address_components[2] and place.address_components[2].short_name or "") ].join(" ")  if place.address_components
#      infowindow.setContent "<div><strong>" + place.name + "</strong><br>" + address
#      infowindow.open map, marker
      
#    setupClickListener = (id, types) ->
#      radioButton = document.getElementById(id)
#      google.maps.event.addDomListener radioButton, "click", ->
#        autocomplete.setTypes types
    types = document.getElementById("type-selector")
    map.controls[google.maps.ControlPosition.LEFT_TOP].push types

#    setupClickListener "changetype-all", []
#    setupClickListener "changetype-address", [ "address" ]
#    setupClickListener "changetype-establishment", [ "establishment" ]
#    setupClickListener "changetype-geocode", [ "geocode" ]

Template.trade.helpers
  userlocation: -> Session.get 'userlocation'
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
Template.trade.rendered = ->
    setPos = (lat, lng) ->
      Session.set "poslat", lat
      Session.set "poslng", lng

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (pos) ->
        setPos pos.coords.latitude, pos.coords.longitude
        , -> setPos 60, 105 # 'Error: The Geolocation service failed.'
    else setPos 60, 105     # Browser doesn't support Geolocation

#    console.log Meteor.user()
    if Meteor.user()
      if 'profile' of Meteor.user()
        unless Meteor.user().profile.timezone
          Meteor.users.update Meteor.userId(),
            $set:
              "profile.timezone": TimezonePicker.detectedZone()
      
#    // slider starts at 20 and 80
    Session.setDefault("price_order", [300])
#    console.log "session", Session.get("price_order")
    # @ ?
    $("#price_order").noUiSlider(
#      snap: true
      start: Session.get("price_order")
      connect: 'lower'
      step: 10
      range:
        min: -300
        '10%': 0
        '70%': 1000
        max: 10000
      format:
        wNumb
#          mark: ','
          decimals: 2
          thousand: ','
          postfix: ' (CAD $)'
    ).on "change", (ev, val) ->
      Session.set "price_order", val
    $('#price_order').Link('lower').to($('#tb_price_order'))
#    $('#price_order').Link('upper').to($('#value-span'))

    $('#price_order').noUiSlider_pips
      mode: 'count'
      values: 5
      density: 3
      steped: true

    new Morris.Bar(
      element: "chartForecastVsQuota"
      data: [
        name: "Guy Bardsley"
        forecast: 2750
        quota: 4000
      ,
        name: "Adam Callahan"
        forecast: 3300
        quota: 4000
      ,
        name: "Arlo Geist"
        forecast: 4500
        quota: 4000
      ,
        name: "Sheila Hutchins"
        forecast: 4100
        quota: 4000
      ,
        name: "Jeanette Quijano"
        forecast: 1800
        quota: 2000
      ,
        name: "Simon Sweet"
        forecast: 6200
        quota: 4000
       ]
      xkey: "name"
      ykeys: [ "forecast", "quota" ]
      labels: [ "Forecast", "Quota" ]
      xLabelAngle: 20
      hideHover: "auto"
    )
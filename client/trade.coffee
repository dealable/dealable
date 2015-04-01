Meteor.subscribe "orders"
#Meteor.subscribe "users"
# set the user's timezone


Template.insertOrder.helpers
  selectBoxProperties: ->
    class: 'form-control'
  userId: -> Meteor.userId
  calendaroptions: ->
    id: 'calendar-order'
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,agendaWeek,agendaDay'
#    defaultView: 'basicWeek'
    selectable: true
    selectHelper: true
    select: (start, end) ->
      title = prompt('Event Title:')
      if (title)
        eventData =
          title: title
          start: start
          end: end
        $('#calendar-order').fullCalendar('renderEvent', eventData, true) # stick? = true
      $('#calendar-order').fullCalendar('unselect')
    editable: true
    eventLimit: true
    events: [
        {
            title: 'All Day Event',
            start: '2015-02-01'
        },
        {
            title: 'Long Event',
            start: '2015-02-07',
            end: '2015-02-10'
        },
        {
            id: 999,
            title: 'Repeating Event',
            start: '2015-02-09T16:00:00'
        },
        {
            id: 999,
            title: 'Repeating Event',
            start: '2015-02-16T16:00:00'
        },
        {
            title: 'Conference',
            start: '2015-02-11',
            end: '2015-02-13'
        },
        {
            title: 'Meeting',
            start: '2015-02-12T10:30:00',
            end: '2015-02-12T12:30:00'
        },
        {
            title: 'Lunch',
            start: '2015-02-12T12:00:00'
        },
        {
            title: 'Meeting',
            start: '2015-02-12T14:30:00'
        },
        {
            title: 'Happy Hour',
            start: '2015-02-12T17:30:00'
        },
        {
            title: 'Dinner',
            start: '2015-02-12T20:00:00'
        },
        {
            title: 'Birthday Party',
            start: '2015-02-13T07:00:00'
        },
        {
            title: 'Click for Google',
            url: 'http://google.com/',
            start: '2015-02-28'
        }
    ]
    
    
#    console.log "Meteor.userId",Meteor.userId
#Template.insertOrder2.helpers
#  userId: -> Meteor.user().username
#  price_order: -> 
#    pr = Session.get "price_order"
#    console.log "pr",pr
#    pr
#  helperdoc: ->
#    # d.getDate(),,d.getMonth(),d.getYear()
##http://maps.googleapis.com/maps/api/geocode/output?parameters
#    product: tb_productid.value
##    user: Meteor.userId
#    time: new Date()
#    price: 0

Template.sellers.helpers
  listsellers: -> Orders.find({direction: "sell"})
Template.buyers.helpers
  listbuyers: -> Orders.find({direction: "buy"})
Template.traded.helpers
  listtransactions: -> Orders.find()
Template.trade.helpers
  userlocation: -> Session.get 'userlocation'


#  
#Template.orderinput.rendered = ->
#  tb_order_time.value = now()
#  tb_order_productid = "id"

#Deps.autorun ->
#store user timezone

Template.trade.rendered = ->
#    console.log Meteor.user()
    if Meteor.user()
      if 'profile' of Meteor.user()
        unless Meteor.user().profile.timezone
          Meteor.users.update Meteor.userId(),
            $set:
              "profile.timezone": TimezonePicker.detectedZone()

    navigator.geolocation.getCurrentPosition((pos)->Session.set 'userlocation', pos)
    
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

#  console.log "next"
#  drawBarChartClosedSales
#drawBarChartClosedSales = ->
#  $("#chartForecastVsQuota").empty()
#  barChartClosedSales = Morris.Bar(
#    element: "chartForecastVsQuota"
#    data: [
#      name: "Guy Bardsley"
#      forecast: 2750
#      quota: 4000
#    ,
#      name: "Adam Callahan"
#      forecast: 3300
#      quota: 4000
#    ,
#      name: "Arlo Geist"
#      forecast: 4500
#      quota: 4000
#    ,
#      name: "Sheila Hutchins"
#      forecast: 4100
#      quota: 4000
#    ,
#      name: "Jeanette Quijano"
#      forecast: 1800
#      quota: 2000
#    ,
#      name: "Simon Sweet"
#      forecast: 6200
#      quota: 4000
#     ]
#    xkey: "name"
#    ykeys: [ "forecast", "quota" ]
#    labels: [ "Forecast", "Quota" ]
#    xLabelAngle: 20
#    hideHover: "auto"
#  )
##on resize of the page: redraw the charts
#$(window).on "resize", ->
#  window.setTimeout (->
#    barChartClosedSales.redraw()  if barChartClosedSales isnt null
#  ), 250
#

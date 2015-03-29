Meteor.subscribe "orders"

#var x = document.getElementById("demo");

Template.insertOrder.events
  "click #fill": ->
    # d.getDate(),,d.getMonth(),d.getYear()
#http://maps.googleapis.com/maps/api/geocode/output?parameters
    showPosition = (position) ->
      window.a = position
    console.log "window.a", window.a
    navigator.geolocation.getCurrentPosition(showPosition)
    product: tb_productid.value
    user: Meteor.userId
    time: new Date()
    price: 0
    location: if window.a then window.a.coords.latitude + "," + window.a.coords.longitude
    
Template.insertOrder.helpers
  helperdoc: ->
    # d.getDate(),,d.getMonth(),d.getYear()
#http://maps.googleapis.com/maps/api/geocode/output?parameters
    showPosition = (position) ->
      window.a = position
    console.log "window.a", window.a
    navigator.geolocation.getCurrentPosition(showPosition)
    product: tb_productid.value
    user: Meteor.userId
    time: new Date()
    price: 0
    location: if window.a then window.a.coords.latitude + "," + window.a.coords.longitude

Template.sellers.helpers
  listsellers: -> Orders.find({direction: "sell"})
Template.buyers.helpers
  listbuyers: -> Orders.find({direction: "buy"})
Template.traded.helpers
  listtransactions: -> Orders.find()
#  
#Template.orderinput.rendered = ->
#  tb_order_time.value = now()
#  tb_order_productid = "id"
  
Template.trade.rendered = ->
#  'click button': ->
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

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
Meteor.subscribe "orders"
#Meteor.subscribe "users"
# set the user's timezone
#
Template.insertOrder.helpers
  s2Opts: ->
    {placeholder: 'foo', tags: true}

Template.sellers.helpers
  listsellers: -> Orders.find({direction: "sell"})
Template.buyers.helpers
  listbuyers: -> Orders.find({direction: "buy"})
Template.traded.helpers
  listtransactions: -> Orders.find()

Template.trade.helpers
  userlocation: -> Session.get 'userlocation'

Template.trade.rendered = ->
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
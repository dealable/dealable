Template.navbar.helpers
  arr3: -> [1..3]
  
#Template.orderinput.events
#  "click #bt_sell": (event) ->
#    Meteor.call "m_orderinput"
#      , "sell"
#      , tb_order_productid.value
#      , Meteor.userId()
#      , Metero.username()
#      , tb_order_price.value
#      , tb_order_location.value
#      , tb_order_time.value
#    false
#  "click #bt_buy": (event) ->
#    Meteor.call "m_orderinput"
#      , "buy"
#      , tb_order_productid.value
#      , Meteor.userId()
#      , tb_order_price.value
#      , tb_order_location.value
#      , tb_order_time.value
#    false

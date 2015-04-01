Template.navbar.helpers
  arr3: -> [1..3]

Accounts.ui.config
  requestPermissions:
    facebook: [ "user_likes" ]
    github: [ "user", "repo" ]
  requestOfflineToken:
    google: true
  passwordSignupFields: "USERNAME_AND_EMAIL"

Template.overview.created = ->
  console.log "Template.overview.created "
  console.log "Accounts._verifyEmailToken", Accounts._verifyEmailToken
  if Accounts._verifyEmailToken
    Accounts.verifyEmail Accounts._verifyEmailToken, (err) ->
      if err?
        console.log "err", err
        console.log "Sorry this verification link has expired."  if err.message = "Verify email link expired [403]"
      else
        console.log "Thank you! Your email address has been confirmed."

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

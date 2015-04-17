AccountsTemplates.configure({
  negativeValidation: false,
  negativeFeedback: false,
  positiveValidation: false,
  positiveFeedback: false,
});

Template.ionicProducts.helpers
  products: -> Products.find()
  bid: -> Orders.findOne({product_id: @_id, direction: "buy"},{sort: {'price': -1}}).price
  offer: -> Orders.findOne({product_id: @_id, direction: "sell"},{sort: {'price': 1}}).price


Template.ionicProducts.events
  "click [data-ion-modal=myModal]": (event, template) ->
    IonBackdrop.retain()
    Meteor.setTimeout (->
      IonBackdrop.release()
    ), 500

  'click .tab-item.buy': (e,a) -> 
    Session.set 'pid', this._id
    Session.set 'pside', "buy"

  'click .tab-item.sell': (e) ->
    Session.set 'pid', this._id
    Session.set 'pside', "sell"

Template.ionicLayout.events
  'click #blogout': ->
    console.log "blogout"
    AccountsTemplates.logout()

Template.userAccounts.events
  "click [data-action='logout']": ->
    console.log "logout"
    AccountsTemplates.logout()
  "click #ioniclogout": ->
    console.log "ioniclogout"
    AccountsTemplates.logout()

Template.orderModal.rendered = ->
    setPos = (lat, lng) ->
      Session.set "poslat", lat
      Session.set "poslng", lng

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (pos) ->
        setPos pos.coords.latitude, pos.coords.longitude

Template.orderModal.helpers
  orderDefaults: ->
    d = new Date()
    user_id: Meteor.userId
    product_id: Session.get 'pid'
#    this._id
    live_order: false
    direction: Session.get 'pside'
    price: 100
    location:
      lat: Session.get "poslat"
      lng: Session.get "poslng"
    dateToMeet: d
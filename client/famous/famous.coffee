#client only code
window.App ?= {}
window.Famous ?={}

Meteor.startup ->  
  Famous.Engine = famous.core.Engine
  Famous.View = famous.core.View
  Famous.Surface = famous.core.Surface
  Famous.Modifier = famous.core.Modifier
  Famous.Transform = famous.core.Transform
  Famous.Draggable = famous.modifiers.Draggable
  Famous.StateModifier = famous.modifiers.StateModifier
  Famous.ModifierChain = famous.modifiers.ModifierChain
  Famous.RenderController = famous.views.RenderController
  Famous.EventHandler = famous.core.EventHandler

  Famous.Scrollview = famous.views.Scrollview
  Famous.HeaderFooterLayout = famous.views.HeaderFooterLayout

  Famous.Easing = famous.transitions.Easing
  Famous.Transitionable = famous.transitions.Transitionable

  Famous.GenericSync     = famous.inputs.GenericSync
  Famous.MouseSync = famous.inputs.MouseSync
  Famous.TouchSync = famous.inputs.TouchSync


  Famous.Timer           = famous.utilities.Timer

  #Famous.FastClick       = famous.inputs.FastClick
  Famous.Transitionable.registerMethod 'spring',famous.transitions.SpringTransition
  Famous.Transitionable.registerMethod 'flip',famous.transitions.easeOutBounce
#  Famous.Transitionable.registerMethod 'slideWindow',famous.transitions.SlideTransition

  Famous.GenericSync.register
    mouse: Famous.MouseSync
    touch: Famous.TouchSync

Template.timbre.helpers
  products: -> Products.find()

Template.product_order.rendered = ->
    setPos = (lat, lng) ->
      Session.set "poslat", lat
      Session.set "poslng", lng

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (pos) ->
        setPos pos.coords.latitude, pos.coords.longitude

Template.product_order.helpers
  orderDefaults: -> Session.get 'orderDefaults'
  pside: -> Session.get 'pside'    

Template.product_overview.helpers
  bid: -> Orders.findOne({product_id: @_id, direction: "buy"},{sort: {'price': -1}}).price
  offer: -> Orders.findOne({product_id: @_id, direction: "sell"},{sort: {'price': 1}}).price
  orderDefaults: Session.get 'orderDefaults'

Template.product_overview.events
  'click .tab-item.buy': (e,a) -> 
    Session.set 'pid', this._id
    Session.set 'pside', "buy"
    d = new Date()
    orderDefaults = 
      user_id: Meteor.userId()
      product_id:this._id
      live_order: false
      direction: "buy"
      price: 100
      location:
        lat: Session.get "poslat"
        lng: Session.get "poslng"
      dateToMeet: d
    Session.set 'orderDefaults', orderDefaults
    
  'click .tab-item.sell': (e) ->
    Session.set 'pid', this._id
    Session.set 'pside', "sell"
    d = new Date()
    orderDefaults = 
      user_id: Meteor.userId()
      product_id: this._id
      live_order: false
      direction: "sell"
      price: 100
      location:
        lat: Session.get "poslat"
        lng: Session.get "poslng"
      dateToMeet: d
    Session.set 'orderDefaults', orderDefaults
    
App.flip = (fview) ->
  console.log "go flip"
#  fview.modifier.halt()
#  fview.modifier.setTransform Famous.Transform.translate(0, 0),
#    method: "spring"
#    period: 200
#    dampingRatio: .2
#    velocity: 0.1
#    method: "flip"
#    curve: 'easeOutBounce'
#    duration: 500
    
  Transform = famous.core.Transform; # see shortcut help below
  # "Fly in" animation (see examples/animations for more)
  fview.modifier.setTransform (Transform.translate -500, -500)
  fview.modifier.setTransform (Transform.translate 0, 0),
    duration: 500
    curve: 'easeOutBounce'
    
    
flipSurface = (event, fview) ->
  console.log "flip fired"
  fview.parent.view.flip curve: 'easeOutBounce', duration: 500
Template.flipper_front.rendered = ->
  console.log "ease flipper"
  FView.from(this).modifierTransition = { curve: 'easeOut', duration: 500 };
Template.flipper_back.rendered = ->
  console.log "ease flipper"
  FView.from(this).modifierTransition = { curve: 'easeOut', duration: 500 };
Template.product_overview.rendered = ->
  console.log "ease flipper"
  FView.from(this).modifierTransition = { curve: 'easeOut', duration: 500 };
Template.product_order.rendered = ->
  console.log "ease flipper"
  FView.from(this).modifierTransition = { curve: 'easeOut', duration: 500 };
Template.flipper_front.famousEvents click: flipSurface
Template.flipper_back.famousEvents click: flipSurface
Template.product_overview.famousEvents click: flipSurface
Template.product_order.famousEvents click: flipSurface



Template.timbre_menu.events
  "click #loginlogout": ->
    console.log "timbre menu"
    Router.go "userAccounts"

Template.loginlogout.famousEvents
  click: ->
    console.log "loginlogout"
    Router.go '/userAccounts'

#Template.flipper_front.rendered = ->
#  fview = FView.from @
#  Transform = famous.core.Transform; # see shortcut help below
#  # "Fly in" animation (see examples/animations for more)
#  fview.modifier.setTransform (Transform.translate -500, -500)
#  fview.modifier.setTransform (Transform.translate 0, 0),
#    duration: 1000
#    curve: 'easeOut'

#Template.flipper.events = ->
#  'click #t1': Session.set 'esTemplate', 'es_surface1'
#  'click #t2': Session.set 'esTemplate', 'es_surface2'
#  'click #t3': Session.set 'esTemplate', 'es_surface3'

#Template.flipper.rendered = ->
#  fview = FView.byId 'f_front'
#  target = fview.surface
#  target.on "click", =>
#    App.flip(fview)
#
#  fview2 = FView.byId 'f_back'
#  target2 = fview2.surface
#  target2.on "click", =>
#    alert 'Home Clicked'
#
#Template.rendertree.helpers
#  items: [
#    {a: 'hi'}
#    {a: 'bye'}
#  ]

App.animateAndIncrement = (fview) ->
  fview.modifier.halt()
  fview.modifier.setTransform Famous.Transform.translate(0, 0),
    method: "spring"
    period: 200
    dampingRatio: .2
    velocity: 0.1
  Session.set "clickCount", Session.get("clickCount") + 1

#
#Template.views_EdgeSwapper.helpers
#  showTemplate: ->
#    Template[@name]
#
#Session.setDefault 'esTemplate', 'es_surface1'
#Template.views_EdgeSwapper.helpers
#  esTemplate: ->
#    Session.get 'esTemplate'
#
#Template.es_buttons.helpers
#  buttons: ['es_surface1', 'es_surface2', 'es_surface3']
#  isSet: ->
#    if @valueOf() is (Session.get 'esTemplate') then 'set' else ''
#Template.es_buttons.events
#  'click button': (event, tpl) ->
#    Session.set 'esTemplate', @valueOf()
    
#    
#Template.clickBox.helpers
#  'clickCount':  ->
#    Session.get 'clickCount'
#
#Template.clickBox.rendered = ->
#  Session.set 'clickCount',50
#  fview = FView.byId 's1'
#  target = fview.surface
#  target.on "click", =>
#    App.animateAndIncrement(fview)
#
#  fview2 = FView.byId 'b1'
#  target2 = fview2.surface
#  target2.on "click", =>
#    alert 'Home Clicked'
#  
#Template.clickBox2.helpers
#  'clickCount':  ->
#    Session.get 'clickCount'
#    
#Template.clickBox2.events
#  'click #b2': (evt,tmp) ->
#      fview = FView.from(tmp)
#      App.animateAndIncrement fview

#
#  Session.set 'menuOpen', false
#
#  # Translation for "main" page, depending on whether menu is open or not
#  Template.screen.helpers
#    menuTranslate: ->
#      if Session.get 'menuOpen' then [300,0,20] else [0,0,20]
#
#  # Set the transition to be used when translate= changes reactively
#  Template.timbre_main.rendered = ->
#    (FView.from @).modifierTransition = curve: 'easeOut', duration: 500
#
#  # On click, toggle the menuOpen state / reactive Session variable
#  Template.timbre_main.famousEvents
#    'click': (event, tpl) ->
#      Session.set 'menuOpen', not Session.get 'menuOpen'
#
#  # Simple queue.  Push functions which will get run and removed every 100ms
#  queue = []
#  Meteor.setInterval ->
#    if queue.length
#      queue.shift()()
#  , 100
#
#  Tracker.autorun ->
#    if Session.get 'menuOpen'
#      _.each (FView.byId 'timbre-menu').children, (strip) ->
#        # Move the strips out of sight immediately
#        strip.modifier.setTransform (Transform.translate -500, 85)
#
#    # And queue them to stagger in back to their original position
#  queue.push ->
#    strip.modifier.setTransform (Transform.translate 0, 0),
#      duration: 500
#      curve: 'easeOut'
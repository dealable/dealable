Router.configure
  layoutTemplate: 'layout'
  yieldRegions:
    'navbar': to: 'top'
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'
  #    urlside: to: 'aside'
  #    urlbottom: to: 'footer'

if Meteor.isClient
  Router.onBeforeAction (->
    if !@ready()
      $('body').addClass 'wait'
    else
      $('body').removeClass 'wait'

    GoogleMaps.load({libraries: 'geometry,places' })
    @next()
  ),
    only: ['trade.item']

Router.route '/',
  name: 'overview'
  onBeforeAction: (pause) ->
      #you could set the user name on user login
      Session.set 'chapp-username','Desired username'
      #The room identifier. Iron router's before action can be a great spot to set this.
      Session.set 'chapp-docid','uniqueIdentifier'
      @next()


#http://ubus:3000/trade/aGBhNTZ4DLZTmPrYb
Router.route '/trade/:_id',
#  waitOn: ->
#    Meteor.subscribe "users" #, Meteor.userId
  name: 'trade.item'
  action: ->
    @layout 'layout'
    item = Products.findOne
            _id: @params._id
    @render 'trade',
      data: item
      
Router.route '/trade/:_id/place',
  name: 'order.place'
  template: 'placeTemplate',
  action: ->
    
#    item = Products.findOne
#            _id: @params._id
#      data: item

    
#Router.route '/trade/:_id', ->
#  @layout 'layout'
Router.map ->
  @route 'git'
  @route 'vid'
  @route 'market'
  @route 'chat'
  @route 'addproduct'
  @route 'insertBookForm'
  @route '/products', ->
    @render 'Products'

PostController = RouteController.extend
  action: ->
      #    // set the reactive state variable "postId" with a value
      #    // of the id from our url
    this.state.set('addproduct', this.params._id);
    this.render();


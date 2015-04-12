Router.configure
  #layoutTemplate: 'layout'
  layoutTemplate: 'FreeLayout'
#  yieldRegions:
#    'navbar': to: 'top'
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'
  #    urlside: to: 'aside'
  #    urlbottom: to: 'footer'
if Meteor.isClient
  Router.onBeforeAction ->
    # loading indicator here
    if !@ready()
      $('body').addClass 'wait'
    else
      $('body').removeClass 'wait'
      @next()
    return
Router.route '/trade2', -> @redirect 'cool_page.sub_page_a'

Router.route '/trade2/sub_page_b', 
  name: 'cool_page.sub_page_b'
  action: -> @redirect 'cool_page.sub_page_b.sub_page_b_1'
  

Router.route '/trade2/sub_page_a',
  name: 'cool_page.sub_page_a'
  template: 'CoolPage'
  yieldRegions:
    'navbar': to: 'top'
    'CoolPageSubPageA': to: 'CoolPageSubcontent'

Router.route '/trade2/sub_page_b_1',
  name: 'cool_page.sub_page_b.sub_page_b_1'
  action: ->
    @render 'CoolPage'
    @render 'navbar', to: 'top'
    @render 'CoolPageSubPageB', to: 'CoolPageSubcontent'
    @render 'subpage', 
      to: 'CoolPageSubPageBSubcontent'
      data: -> {title: 'Sub-page B-1'}
    @render 'lorem1', to: 'subpagecontent'
Router.route '/trade2/sub_page_b_2',
  name: 'cool_page.sub_page_b.sub_page_b_2'
  action: -> 
    @render 'CoolPage'
    @render 'navbar', to: 'top'
    @render 'CoolPageSubPageB', to: 'CoolPageSubcontent'
    @render 'CoolPageSubPageBSubPageB2', to: 'CoolPageSubPageBSubcontent'

#Router.route '/trade2/sub_page_b',
#  name: 'trade2.sub_page_b'
#  template: 'trade2'
#  yieldRegions:
#    'navbar': to: 'top'
#    'CoolPageSubPageBSubPageB2': to: 'CoolPageSubPageBSubcontent'
#    'CoolPageSubPageB': to: 'CoolPageSubcontent'

Router.route '/trade2/:_id',
#  waitOn: ->
#    Meteor.subscribe "users" #, Meteor.userId
  name: 'trade2.item'
  template: 'CoolPage'
  data: -> Products.findOne _id: @params._id
#  yieldRegions: 'CoolPageSubPageBSubPageB2': to: 'CoolPageSubcontent'

#http://ubus:3000/trade/aGBhNTZ4DLZTmPrYb
Router.route '/trade/:_id',
#  waitOn: ->
#    Meteor.subscribe "users" #, Meteor.userId
  name: 'trade.item'
  template: 'trade'
  data: -> Products.findOne _id: @params._id
      
    
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




#Router.route '/trade2/:_id/place',
#  name: 'order2.place'
#  template: 'placeTemplate2',
#  action: ->

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


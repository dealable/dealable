Router.configure
  layoutTemplate: 'ApplicationLayout'
  yieldRegions:
    navbar: to: 'top'
#    urlside: to: 'aside'
#    urlbottom: to: 'footer'

Router.route '/',
  (-> @render()),
  name: 'overview'
  
#http://ubus:3000/trade/aGBhNTZ4DLZTmPrYb
Router.route '/trade/:_id', ->
  @layout 'ApplicationLayout'
  item = Products.findOne
          _id: @params._id
  @render 'trade',
    data: item
    
#Router.route '/trade/:_id', ->
#  @layout 'ApplicationLayout'

Router.route 'git'
Router.route 'vid'
Router.route 'market'
Router.route 'addproduct'
Router.route 'insertBookForm'

Router.route '/products', ->
  @render 'Products'



Router.route '/files/:filename', (->
  @response.end 'hi from the server\n'
),
  where: 'server'

Router.route('/restful',
  where: 'server'
).get(->
  @response.end 'get request\n'
).post ->
  @response.end 'post request\n'

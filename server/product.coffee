Meteor.publish "products", -> Products.find()
Meteor.publish "orders", -> Orders.find()
  
Meteor.methods
  m_orderinput: (direction, product, user, price, location, time) ->
    console.log "m_orderinput", price, location, time
    orderobj =
      direction: direction
      product: product
      user: user
      price: price
      location: location
      time: time
    Orders.insert orderobj
    console.log "order sumbitted"

  listproducts: ->
    console.log "listing"
    res = Products.find()
    console.log "res", res
    res
  addamzn: (objraw) ->
    console.log objraw.name
    objproduct = {}
    labeltokey = (label) -> switch label
        when "ASIN" then "ASIN"
        when "Product Dimensions" then "size"
        when "Shipping Weight" then "weight"
        when "Item model number" then "model"
        else "unknownlabel"
#    labels = ["ASIN","Product Dimensions","Shipping Weight","Item model number"]
    objproduct.name = objraw.name
    for detail in objraw.info.details
      key = labeltokey detail.field
      if key isnt "unknownlabel"
        objproduct[key] = detail.data
    Products.insert objproduct
#    objproduct = 
#      ASIN:
#      name:
      
#    console.log "Products",Products.find({ASIN: ""})
#    Products.insert
    


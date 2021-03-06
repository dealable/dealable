@Products = new Mongo.Collection "products"
@Orders = new Mongo.Collection "orders"

# Any client may insert, update, or remove a post without restriction
#@Products.permit(['insert', 'update', 'remove']).apply()
#@Orders.permit(['insert', 'update', 'remove']).apply()

@Products.attachSchema(new SimpleSchema({
  name: {
    type: String,
    label: "Name of product",
  }
  ASIN: {
    type: String,
    label: "Amazon ASIN number"
  },
  amzn_url: {
    type: String,
    label: "Amazon URL"
  },                               
  size: {
    type: String,
    label: "product ID"
    max: 100
    optional: true
  },
  weight: 
    type: String
    label: "weight"
    optional: true

  model: {
    type: Number,
    label: "Item model number"
    optional: true
  },
  mfg_id: {
    type: String,
    label: "Manufacturer's Product ID"
    optional: true
  }
}));

@Orders.attachSchema(new SimpleSchema({
  direction: {
    type: String,
    label: "buy/sell",
    max: 3
  },
  product:
    type: String,
    label: "product ID"
    max: 100

  user: {
    type: String,
    label: "User ID"
  },
  price: {
    type: Number,
    label: "Price"
  },
  time: {
    type: Date,
    label: "Date and time"
  },
  location: {
    type: String,
    label: "Location"
  }
}));
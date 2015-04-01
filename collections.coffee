@Schemas = {}
@Products = new Mongo.Collection "products"
@Orders = new Mongo.Collection "orders"

#install cfs:filesystem cfs:standard-packages 
#@Images = new FS.Collection("images",
#  stores: [new FS.Store.FileSystem("images", {path: "~/images"})]
#)

# Any client may insert, update, or remove a post without restriction
#@Products.permit(['insert', 'update', 'remove']).apply()
#@Orders.permit(['insert', 'update', 'remove']).apply()

#@Products.attachSchema(new SimpleSchema({
Products.attachSchema(Schemas.Products)
Schemas.Products = (new SimpleSchema({
  name: {
    type: String,
    label: "Name of product",
    optional: true
  }
  ASIN: {
    type: String,
    label: "Amazon ASIN number"
    optional: true
  },
  amzn_url: {
    type: String,
    label: "Amazon URL"
    optional: true
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
    type: String,
    label: "Item model number"
    optional: true
  },
  mfg_id: {
    type: String,
    label: "Manufacturer's Product ID"
    optional: true
  },
  img_src: {
    type: String,
    label: "Image Source"
    optional: true
  }
}));


AddressSchema = new SimpleSchema
  country:
    type: String
  zipcode:
    type: String
  near_station:
    type: Boolean
# consider using datetime interval data type for performance. Closure has date interval
TimeIntervalSchema = new SimpleSchema
  timezone:
    type: String
  time_from:
    type: Date # datetime using input type=datetime
    autoform:
      afFieldInput:
        type: "bootstrap-datetimepicker"
        timezoneId: "PST"
        dateTimePickerOptions:
          sideBySide: true
          stepping: 15

  time_until:
    type: Date
    autoform:
      afFieldInput:
        type: "bootstrap-datetimepicker"
        timezoneId: "America/New_York"
        dateTimePickerOptions:
          sideBySide: true
          stepping: 15
OrderSchema = new SimpleSchema
  user_id:
    type: String
  product_id:
    type: String
  live_order:
    label: "Live order - trade is irreversibly autocompleted if a match meets all your conditions"
    type: Boolean
  direction:
    type: String
    allowedValues: ["buy","sell"]
  price:
    type: Number
  location:
    type: AddressSchema
  times:
    type: [TimeIntervalSchema]

@Orders.attachSchema(OrderSchema)

@AdminConfig = {
  name: 'My App'
  adminEmails: ['a@b.com']
  collections: {
    Products: {}
    Orders: {}
  }
}
  #    regEx: /^A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]$/
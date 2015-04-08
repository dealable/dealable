
@Schemas = new Mongo.Collection "schemas"
@Products = new Mongo.Collection "products"
@Orders = new Mongo.Collection "orders"

DetailVoteSchema = new SimpleSchema
  voter:
    type: String
  date:
    type: Date
  reason:
    type: String
    optional: true

CollectionDetailSchema = new SimpleSchema
  name:
    type: String
  type:
    type: String
  allowedValues:
    type: [String]
    optional: true
  addedby:
    type: String
#    defaultValue: Meteor.userId()
  addedDate:
    type: Date
#  upvoteCount:
#    type: Number
#    defaultValue: 0
#  downvoteCount:
#    type: Number
#    defaultValue: 0
#  upvotes:
#    type: DetailVoteSchema
#    defaultValue: {}
#    optional: true
#  downvotes:
#    type: DetailVoteSchema
#    defaultValue: {}

@Schemas.attachSchema(new SimpleSchema
  name:
    type: String
  fields:
    type: [CollectionDetailSchema]
)

#install cfs:filesystem cfs:standard-packages 
#@Images = new FS.Collection("images",
#  stores: [new FS.Store.FileSystem("images", {path: "~/images"})]
#)

# Any client may insert, update, or remove a post without restriction
#@Products.permit(['insert', 'update', 'remove']).apply()
#@Orders.permit(['insert', 'update', 'remove']).apply()

#@Products.attachSchema(new SimpleSchema({

productSchema = (new SimpleSchema({
  name: {
    type: String,
    label: "Name of product",
  }
  mfg_url:
    type: String,
    label: "Manufacturer URL"
  model: {
    type: String,
    label: "Item model number"
    optional: true
  }
  img_url: {
    type: String,
    label: "Image URL"
  }
#  ASIN: {
#    type: String,
#    label: "Amazon ASIN number"
#    optional: true
#  },
#  amzn_url: {
#    type: String,
#    label: "Amazon URL"
#    optional: true
#  },                               
#  size: {
#    type: String,
#    label: "product ID"
#    max: 100
#    optional: true
#  },
#  weight: 
#    type: String
#    label: "weight"
#    optional: true


#  mfg_id: {
#    type: String,
#    label: "Manufacturer's Product ID"
#    optional: true
#  },

}));

@Products.attachSchema(productSchema)

AddressSchema = new SimpleSchema
  lat:
    type: Number
    decimal: true
  lng:
    type: Number
    decimal: true
#  country:
#    type: String
#  zipcode:
#    type: String
#  near_station:
#    type: Boolean
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
    label: "User ID"
  product_id:
    type: String
    label: "Product ID"
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
  dateToMeet:
    type: Date
#  times:
#    type: [TimeIntervalSchema]
#extra conditions


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
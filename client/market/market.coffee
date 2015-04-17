Template.listproducts.helpers
  listproducts: -> Products.find()
  #Meteor.call "listproducts"

Template.listproducts.events
  "click .delete": -> Products.remove(this._id)
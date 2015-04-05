TabularTables = {};

Meteor.isClient && Template.registerHelper('TabularTables', TabularTables);

TabularTables.Schemas = new Tabular.Table({
  name: "BookList",
  collection: Schemas,
  columns: [
    {data: "name", title: "Schema Name"},
    {data: "fields", title: "Field Details"},
#    {data: "copies", title: "Copies Available"},
#    {
#      data: "lastCheckedOut",
#      title: "Last Checkout",
#      render: function (val, type, doc) {
#        if (val instanceof Date) {
#          return moment(val).calendar();
#        } else {
#          return "Never";
#        }
#      }
#    },
#    {data: "summary", title: "Summary"},
    {
      tmpl: Meteor.isClient && Template.bookCheckOutCell
    }
  ]
});
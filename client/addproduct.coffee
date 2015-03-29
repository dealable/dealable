Meteor.subscribe "products"

Template.addamzn.helpers
  amznUrl: -> amzn.url
  amznRoot: -> amzn.root
  amznName: -> amzn.name
  amznimgsrc: -> amzn.img_src
  amznDataroot: -> amzn.dataroot
  amznHeader: -> amzn.header
  amznData: -> amzn.data
  nameCount: -> (Session.get "amzn").name.length
  name:      -> (Session.get "amzn").name # join(" ")
  img_src: -> (Session.get "amzn").img_src # join(" ")
  detailsCount:   -> (Session.get "amzn").info.details.length
  header: -> 
    details = (Session.get "amzn").info.details
    for detail in details
      detail.field
  data: -> 
    details = (Session.get "amzn").info.details
    for detail in details
      detail.data

Template.addamzn.events
  "click #bt_addamzn": ->
#    var res = {name: "Rock", detail: "Roll"}
    # {name:"test",info:{details:{name:"detail1"}}}
    Meteor.call "addamzn", Session.get "amzn"
  "click #bt_amzn": (event) ->
    templ =
      url: tb_amzn.value
      root: tb_amzn_root.value
      name: tb_amzn_name.value
      img_src: tb_amzn_imgsrc.value
      dataroot: tb_amzn_dataroot.value
      header: tb_amzn_header.value
      data: tb_amzn_data.value

    Meteor.call "xrayScrape"
      , templ
      , (error, result) ->
#        console.log "click ", result
#        Session.set "table", result
          console.log "extracted ", result
          Session.set "amzn", result
    false

  "click #bt_header": (event) ->
    Meteor.call "chScrape"
      , tb_url.value
      , tb_header.value
      , (error, result) ->
        console.log "click ", result
        Session.set "header", result
    false

  "click #bt_data": (event) ->
    Meteor.call "jqScrape"
      , tb_url.value
      , tb_data.value
      , (error, result) ->
        console.log "click ", result
        Session.set "data", result
    false

  "click #bt_table": (event) ->
    Meteor.call "xrayScrapeText"
      , tb_url.value
      , tb_table_root.value
      , tb_table_header.value
      , tb_table_data.value
      , (error, result) ->
        console.log "click ", result
        Session.set "table", result
    false

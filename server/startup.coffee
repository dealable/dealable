Meteor.startup ->
  Meteor.call "chScrape"
    , amzn.url
    , amzn.root + amzn.header
    , (error, result) ->
      console.log "startup", result
Meteor.methods
  xrayScrape: (templ) -> 
    console.log "start", templ
#      check coffeescript self-initiating functions
    future = new (Npm.require 'fibers/future')()
    rmNewLines = (str) -> str.replace(/(\r\n|\n|\r)/g,"").trim()
    getURL = (str) ->
      patt = /\"([\w\n\:\/_\-\.]+)\"/g
      arr = while match = patt.exec(str)
        match[1]
      arr[0]
    xray templ.url 
      # prepare can only (str->str) but do as much as possible
      .prepare('rmNewLines', rmNewLines)
      .prepare('getURL', getURL)
      .select({
        name: templ.name,
        img_src: templ.img_src + " | getURL",
#        img: templ.imgsrc,
        info: {
          $root: templ.dataroot,
          details: [{
            field: templ.header + " | rmNewLines" # | rmColon | rmNewLines",
            data: templ.data + " | rmNewLines" # | rmHeaderName"  # + " | " +  rmHeaderName  + " | " + rmJS  
          }]
        }})
      .run (err,product)->
        for detail in product.info.details
          header = detail.field
          if header in ["Amazon Best Sellers Rank:", "Average Customer Review:"]
            detail.data = ""
          else
            detail.data = detail.data.replace(header,"").trim()
          detail
          detail.field = header.replace(":","")
        console.log "before", product.info.details
        product.info.details.push {field: "name", data: product.name}, {field: "img_src", data: product.img_src}, {field: "amzn_url", data: templ.url}
        console.log "after", product.info.details
        future.return product
#        .write(process.stdout)
    xrayResults = do future.wait
    xrayResults.amzn_url = templ.url
    console.log "xrayResults", (JSON.stringify xrayResults)
    xrayResults
    
  ###  scrape using cheerio.js ###
  chScrape: (url, format) -> 
    html = Meteor.http.get url

    $ = Meteor.npmRequire("cheerio").load html.content
    chResults = $(format).map (i, elem) ->
        elemtext = $(elem).text().replace(/(\r\n|\n|\r)/g,"")
        console.log "chResults: ", elemtext
        elemtext
      .get()
    chResults

#  ###  scrape using jsdom/jquery ###
#  jqScrape: (url,format) ->
#    html = Meteor.http.get url
#
#    # http://stackoverflow.com/questions/21358015/error-jquery-requires-a-window-with-a-document
#    jq = Meteor.npmRequire("jquery")(Meteor.npmRequire("jsdom").jsdom().parentWindow)
#    jqDoc = jq html.content
#
#    # http://stackoverflow.com/questions/23866237/jquery-cheerio-going-over-an-array-of-elements
#    jqResults = jqDoc.find(format).map (i, elem) ->
#        elemtext = jq(elem).val().replace(/(\r\n|\n|\r)/g,"")
#        console.log "jqResults: ", elemtext
#        elemtext
#      .get()
#    jqResults
#
#  ###  scrape using x-ray.js ###
#  xrayScrapeText: (url, root, header, data) -> 
##      check coffeescript self-initiating functions
#    future = new (Npm.require 'fibers/future')()
#    xray url
#      .select([{
#        $root: [root],
#        headers: [header]
#        data: [data]
##          headers: [header]
##          data: [data]
#        }])
#      .run (err,rowarr)->
#        rowtextarr = for row in rowarr
#          rowtext = ([row.headers..., row.data...]).join(" ") 
#          console.log "xrayResults", rowtext
#          rowtext
#        future.return rowtextarr
#    xrayResults = do future.wait
#    xrayResults
#  #    .write(process.stdout)
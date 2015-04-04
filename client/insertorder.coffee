Template.insertOrder.helpers
  selectBoxProperties: ->
    class: 'form-control'
  userId: -> Meteor.userId
  calendaroptions: -> ## add delete, timezone
    id: 'calendar-order'
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,agendaWeek'
    defaultView: 'agendaWeek'
    selectable: true
    selectHelper: true
    select: (start, end) ->
      title = "available"
#      title = prompt('Event Title:')
      if (title)
        eventData =
          title: title
          start: start
          end: end
        $('#calendar-order').fullCalendar('renderEvent', eventData, true) # stick? = true
      $('#calendar-order').fullCalendar('unselect')
      console.log "all events", $('#calendar-order').fullCalendar('clientEvents')
    editable: true
    eventLimit: true
    events: [
        {
            title: 'All Day Event',
            start: '2015-04-01'
        },
        {
            title: 'Long Event',
            start: '2015-04-07',
            end: '2015-04-10'
        },
        {
            id: 999,
            title: 'Repeating Event',
            start: '2015-04-09T16:00:00'
        },
        {
            id: 999,
            title: '9.0Repeating Event9',
            start: '2015-04-16T16:00:00'
        },
        {
            title: 'Conference',
            start: '2015-04-11',
            end: '2015-04-13'
        },
        {
            title: 'Meeting',
            start: '2015-04-12T10:30:00',
            end: '2015-04-12T12:30:00'
        },
        {
            title: 'Lunch',
            start: '2015-04-12T12:00:00'
        },
        {
            title: 'Meeting',
            start: '2015-04-12T14:30:00'
        },
        {
            title: 'Happy Hour',
            start: '2015-04-12T17:30:00'
        },
        {
            title: 'Dinner',
            start: '2015-04-12T20:00:00'
        },
        {
            title: 'Birthday Party',
            start: '2015-04-13T07:00:00'
        },
        {
            title: 'Click for Google',
            url: 'http://google.com/',
            start: '2015-04-28'
        }
    ]


#    console.log "Meteor.userId",Meteor.userId
#Template.insertOrder2.helpers
#  userId: -> Meteor.user().username
#  price_order: -> 
#    pr = Session.get "price_order"
#    console.log "pr",pr
#    pr
#  helperdoc: ->
#    # d.getDate(),,d.getMonth(),d.getYear()
##http://maps.googleapis.com/maps/api/geocode/output?parameters
#    product: tb_productid.value
##    user: Meteor.userId
#    time: new Date()
#    price: 0


#  
#Template.orderinput.rendered = ->
#  tb_order_time.value = now()
#  tb_order_productid = "id"

#Deps.autorun ->
#store user timezone


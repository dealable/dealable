//Menu.add({name:'Timbre Menu',route:'examples/timbre'}, 'Examples');

Session.set('menuOpen', false);

// Translation for "main" page, depending on whether menu is open or not
Template.timbre.helpers({
  menuTranslate: function() {
    return Session.get('menuOpen') ? [240,0,20] : [0,0,20];
  }
});

// Set the transition to be used when translate= changes reactively
Template.timbre_main.rendered = function() {
  FView.from(this).modifierTransition = { curve: 'easeOut', duration: 500 };
};

// On click, toggle the menuOpen state / reactive Session variable
Template.timbre_header.famousEvents({
  'click': function(event, tpl) {
    console.log ("timbre_main.famousEvents")
    Session.set('menuOpen', !Session.get('menuOpen'));
  }
});

// Simple queue.  Push functions which will get run and removed every 100ms
var queue = [];
Meteor.setInterval(function() {
  if (queue.length)
    queue.shift()();
}, 50);

Deps.autorun(function() {
  if (Session.get('menuOpen'))
    _.each(FView.byId('timbre-menu').children, function(strip) {
      // Move the strips out of sight immediately
      strip.modifier.setTransform(Famous.Transform.translate(-500,85));

      // And queue them to stagger in back to their original position
      queue.push(function() {
        strip.modifier.setTransform(Famous.Transform.translate(0,0),
          { duration: 500, curve: 'easeOut' });
      });
    });
});

if Meteor.isClient
  
  # counter starts at 0
  Session.setDefault "counter", 0
  Template.welcome.helpers counter: ->
    Session.get "counter"

  Template.welcome.events "click button": ->
    
    # increment the counter when button is clicked
    Session.set "counter", Session.get("counter") + 1
    return

if Meteor.isServer
  Meteor.startup ->

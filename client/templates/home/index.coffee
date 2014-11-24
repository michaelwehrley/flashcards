Session.setDefault 'counter', 0

Template.homeIndex.helpers counter: ->
  Session.get 'counter'

Template.homeIndex.events 'click button': ->
  # increment the counter when button is clicked
  Session.set "counter", Session.get("counter") + 1
  return

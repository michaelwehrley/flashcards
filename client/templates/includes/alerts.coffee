Template.alerts.helpers
  alerts: ->
    Alerts.find()

Template.alert.rendered = ->
  Meteor.defer ->
    Alerts.update(@data._id, {$set: {seen: true}})
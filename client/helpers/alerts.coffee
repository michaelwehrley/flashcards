# Local (client-only) collection
@Alerts = new Meteor.Collection(null)

@throwAlert = (alertPrefix, message, alertType) ->
  $('.alert').remove()
  Alerts.insert({message: message, alertPrefix, alertType})

@clearAlerts = -> 
  Alerts.remove({seen: true})
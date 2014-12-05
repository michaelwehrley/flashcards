Meteor.publish 'questions', ->
  Questions.find()

Meteor.publish 'questionResponses', ->
  Responses.find()
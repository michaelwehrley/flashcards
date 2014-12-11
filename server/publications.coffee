# Improve scopes here by userId
Meteor.publish 'questions', ->
  Questions.find()

Meteor.publish 'responses', ->
  Responses.find()

Meteor.publish 'challenges', ->
  Challenges.find()
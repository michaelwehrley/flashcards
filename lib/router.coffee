Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: ->
    Meteor.subscribe('questions')
    Meteor.subscribe('challenges')

Router.route '/',
  name: 'homeIndex'
  waitOn: ->
    Session.set('duration', 0)
    Session.set('record', false)

Router.route '/questions',
  name: 'questionsIndex'

Router.route '/questions/:_id',
  name: 'questionsShow'
  data: ->
    Questions.findOne @params._id

Router.route '/questions/:_id/responses',
  name: 'responsesIndex'
  data: ->
    Questions.findOne @params._id
  waitOn: ->
    Meteor.subscribe('responses')

Router.route '/challenges/:_id',
  name: 'challengesShow'
  data: ->
    Challenges.findOne @params._id

Router.route '/challenges/:_challengeId/questions/:_questionId/responses/new',
  name: 'responsesNew'
  data: ->
    Session.set('record', true)
    {
      challenge: Challenges.findOne @params._challengeId
      question: Questions.findOne @params._questionId
    }

Router.onBeforeAction 'dataNotFound',
  only: 'homeIndex'
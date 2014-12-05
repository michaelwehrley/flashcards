Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: ->
    Meteor.subscribe('questions')

Router.route '/',
  name: 'homeIndex'

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
    Meteor.subscribe('questionResponses')

Router.route '/questions/:_id/responses/new',
  name: 'responsesNew'
  data: ->
    Questions.findOne @params._id

Router.onBeforeAction 'dataNotFound',
  only: 'homeIndex'
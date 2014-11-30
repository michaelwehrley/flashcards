Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: ->
    Meteor.subscribe('questions')

Router.route('/', {name: 'homeIndex'})

Router.route('/questions', {name: 'questionsIndex'})

Router.route "/questions/:_id",
  name: "questionShow"
  data: ->
    Questions.findOne @params._id

Router.onBeforeAction 'dataNotFound', {only: 'homeIndex'}
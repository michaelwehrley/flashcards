Template.responseNew.events

  'click button': (event) ->
    event.preventDefault()
    question = _.sample(Questions.find().fetch(), 1)[0]
    Router.go('responseNew', question)
    false
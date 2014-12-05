Template.homeIndex.events

  'click button': (event) ->
    event.preventDefault()
    question = _.sample(Questions.find().fetch(), 1)[0]
    Router.go('responsesNew', question)
    throwAlert "Level", 1, "info"
    false
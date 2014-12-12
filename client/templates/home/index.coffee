Template.homeIndex.helpers

  levels: ->
    _.range(1, 18)

Template.homeIndex.events

  'click a.list-group-item': (event) ->
    event.preventDefault()
    level = event
              .currentTarget
              .dataset["level"]
    questions = Questions
                  .find(level: level)
    shuffledQuestions = _.shuffle questions.fetch()
    shuffledQuestionIds = _.map(shuffledQuestions, (question) ->
                            question._id
                          )

    challengeId = Challenges.insert({
      duration: 0
      isFinished: false
      level: level
      questionIds: shuffledQuestionIds
      userId: "guest"
    })

    Router.go('responsesNew', {
      _challengeId: challengeId,
      _questionId: _.first(shuffledQuestionIds)
    })
    throwAlert "Level", 1, "info"

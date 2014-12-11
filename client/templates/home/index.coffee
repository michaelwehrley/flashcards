Template.homeIndex.events

  'click button': (event) ->
    value = event.currentTarget.value
    questions = Questions
                  .find(level: value)
    shuffledQuestions = _.shuffle questions.fetch()
    shuffledQuestionIds = _.map(shuffledQuestions, (question) ->
                            question._id
                          )

    challengeId = Challenges.insert({
      duration: 0
      isFinished: false
      level: value
      questionIds: shuffledQuestionIds
      userId: "guest"
    })

    Router.go('responsesNew', {
      _challengeId: challengeId,
      _questionId: _.first(shuffledQuestionIds)
    })
    throwAlert "Level", 1, "info"
    false
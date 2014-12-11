Template.responsesNew.events

  'click button[type="button"]': (event) ->
    # '@' & 'this' are the json object passed in

    # get/set buttonClicks
    buttonClicks = Session.get('buttonClicks')
    buttonClicks = buttonClicks || 0
    buttonClicks = buttonClicks + 1 # ++
    Session.set('buttonClicks', buttonClicks)

    # get/set userInput
    userInput = Session.get('userInput') || ''
    userInput = userInput + event.currentTarget.value 
    Session.set('userInput', userInput)

    throwAlert "Current Response:", userInput, "info"

    if buttonClicks == @question.product.toString().length
      userInput = parseInt(userInput)
      response = {
        buttonClicks: buttonClicks
        challengeId: @challenge._id
        questionId: @question._id
        userInput: userInput
        # timestamps
        createdAt: new Date().getTime()
        updatedAt: new Date().getTime()
      }
      if userInput == @question.product
        response.isCorrect = true
        throwAlert "Congrats!", userInput + " was correct.", "success"
      else
        response.isCorrect = false
        throwAlert "Whoops.", "The correct answer was " + @question.product + " not " + userInput, "danger"
      Meteor.call "submitResponse", response, (error, id) ->
        if error
          throwAlert error.reason, "Error!", "danger"
          Router.go('responsesNew', @question._id)

      # Get next question
      questionIds = @challenge.questionIds
      currentQuestionIndex = _.indexOf(questionIds, @question._id)
      nextQuestionId = questionIds[currentQuestionIndex + 1]

      # Reset
      Session.set('buttonClicks', 0)
      Session.set('userInput', '')
      Router.go('responsesNew', {
        _challengeId: @challenge._id, _questionId: nextQuestionId
      })
    false
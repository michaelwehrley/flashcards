Template.responsesNew.rendered = ->
  setInterval(->
      if Session.get('record')
        unless Session.get('duration') then Session.set('duration', 0)
        duration = Session.get('duration') + 500
        Session.set('duration', duration)
        console.log(Session.get('duration'))
    , 500)

Template.responsesNew.helpers

  problem: ->
    factors = [@question.factorA, @question.factorB]
    firstFactor = _.sample factors
    secondFactorArray = _.reject(factors, (factor) ->
                    factor == firstFactor)

    if secondFactorArray.length == 0
      secondFactor = firstFactor
    else
      secondFactor = secondFactorArray[0]

    firstFactor + " &times; " + secondFactor

  totalDuration: ->
    Session.get('duration')

Template.responsesNew.events

  'click button[type="button"]': (event) ->
    event.preventDefault()

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
      # Stop timing
      Session.set('record', false)

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

      # Update Challenge with duration
      Challenges.update @challenge._id,
        { $set:
          {
            duration: Session.get('duration')
          }
        }, (error) ->
          throw new Meteor.Error(401, error.message) if error

      # View next question or results page
      if questionIds.length > currentQuestionIndex + 1
        Router.go('responsesNew', {
          _challengeId: @challenge._id, _questionId: nextQuestionId
        })
      else
        # set challenge as is complete true!
        Challenges.update @challenge._id,
          { $set:
            {
              isFinished: true
            }
          }, (error) ->
            throw new Meteor.Error(401, error.message) if error
        Router.go('challengesShow', @challenge)
    false
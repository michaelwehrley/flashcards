Template.responsesNew.events

  'click button[type="button"]': (event) ->
    event.preventDefault()

    # set/get buttonClicks
    buttonClicks = Session.get('buttonClicks')
    buttonClicks = buttonClicks || 0
    buttonClicks = buttonClicks + 1 # ++
    Session.set('buttonClicks', buttonClicks)

    # set/get userInput
    userInput = Session.get('userInput') || ''
    userInput = userInput + event.currentTarget.value 
    Session.set('userInput', userInput)

    question = Questions.findOne(@_id)

    throwAlert "Current Response:", userInput, "info"

    if buttonClicks == question.product.toString().length
      userInput = parseInt(userInput)
      response = {
        buttonClicks: buttonClicks
        questionId: @_id
        userInput: userInput
        # timestamps
        createdAt: new Date().getTime()
        updatedAt: new Date().getTime()
      }
      if userInput == question.product
        throwAlert "Congrats!", userInput + " was correct.", "success"
      else
        throwAlert "Whoops.", "The correct answer was " + question.product + " not " + userInput, "danger"
      Meteor.call "submitResponse", response, (error, id) ->
        if error
          throwAlert error.reason, "Error!", "danger"
        else
          nextQuestion = _.sample(Questions.find().fetch(), 1)[0]
          Session.set('buttonClicks', 0)
          Session.set('userInput', '')
          Router.go('responsesNew', nextQuestion)
    # false
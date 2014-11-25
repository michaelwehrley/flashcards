Template.homeIndex.submitResponse = ->
  answer = Session.get('answer')
  response = Session.get('response')
  if parseInt(response.answer) == answer.product
    throwAlert "Well done!", "Correct answer!", "success"
  else
    throwAlert "Sorry.", "Incorrect answer.", "danger"

Template.homeIndex.helpers

  questionContent: ->
    # ToDo: Create publishable question object
    # AND seed db with all questions in order to keep a history
    # of comman responses etc
    question = {}
    factorA = Math.floor((Math.random() * 25) + 1)
    factorB = Math.floor((Math.random() * 25) + 1)

    question.factorA = factorA
    question.factorB = factorB
    question.content = factorA.toString() + " &times; " + factorB.toString()
    Session.set('question', question)

    # ToDo: Create publishable answer object with question id
    answer = {}
    product = factorA * factorB
    answer.product = product
    answer.length = product.toString().length
    Session.set('answer', answer)

    # ToDo: Create publishable response object with answer id and question id
    response = {}
    response.clicks = 0
    response.answer = "" # keep as string to append more responses
    Session.set('response', response)

    return question.content

  currentResponse: ->
    Session.get('response')

Template.homeIndex.events

  'click form button': (event) ->
    event.preventDefault()
    answer = Session.get('answer')
    question = Session.get('question')
    response = Session.get('response')
    response.answer = response.answer + event.target.value
    response.clicks += 1
    Session.set('response', response)
    if response.clicks == answer.length then Template.homeIndex.submitResponse()
Template.homeIndex.submitResponse = ->
  # answer = Session.get('answer')
  # response = Session.get('response')
  # if parseInt(response.answer) == answer.product
  #   throwAlert "Well done!", "Correct answer!", "success"
  # else
  #   throwAlert "Sorry.", "Incorrect answer.", "danger"

Template.homeIndex.helpers

  # questionContent: ->

  # currentResponse: ->
  #   Session.get('response')

Template.homeIndex.events

  'click form button': (event) ->
    event.preventDefault()
    # response.answer = response.answer + event.target.value
    # response.clicks += 1
    # Session.set('response', response)
    # if response.clicks == answer.length then Template.homeIndex.submitResponse()
Template.responsesIndex.helpers

  responses: ->
    Responses.find {
      questionId: @_id
    }
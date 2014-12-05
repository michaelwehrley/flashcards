@Responses = new Mongo.Collection('responses')

Meteor.methods

  submitResponse: (response) ->
    # user = Meteor.user()
    # throw new Meteor.Error(401, "You need to log in to record responses") unless user
    Responses.insert response, (error) ->
      if error
        throw new Meteor.Error(401, error.message)
      else
        Questions.update(
          response.questionId, {
            # $addToSet: {
            #   questionResponders: user._id
            # },
            $inc: {responseCount: 1}
          }
        )
# Responses.allow
#   update: (userId, response) ->
#     ownsDocument userId, response

#   remove: (userId, response) ->
#     ownsDocument userId, response
@Questions = new Mongo.Collection('questions')

# Questions.allow
#   update: (userId, question) ->
#     ownsDocument userId, question

#   remove: (userId, question) ->
#     ownsDocument userId, question
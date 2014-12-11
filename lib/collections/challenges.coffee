@Challenges = new Mongo.Collection('challenges')

# Challenges.allow
#   update: (userId, challenge) ->
#     ownsDocument userId, challenge

#   remove: (userId, challenge) ->
#     ownsDocument userId, challenge
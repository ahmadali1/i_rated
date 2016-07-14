@.average_ratings = (id, score) ->
  $(id).raty
    readOnly: true
    half: true
    score: score
    path: '/assets'

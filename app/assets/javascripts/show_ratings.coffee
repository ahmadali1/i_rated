overall_rating = ->
  average_ratings '#star', $('#movie-data').data('overall-rating')

post_rating = ->
  $('#user-star').raty
    score: 0
    path: '/assets'
    click: (score, evt) ->
      movie_id = $('#user-star').data('movie-id')
      $.ajax(
        url: '/movies/' + movie_id + '/ratings'
        type: 'POST'
        data: { rating: { score: score } }).done (data) ->

update_rating = ->
  $('#rating-star').raty
    score: $('#rating-star').data('movie-ratings')
    path: '/assets'
    click: (score, evt) ->
      movie_id = $('#rating-star').data('movie-id')
      rating_id = $('#rating-star').data('rating-id')
      $.ajax(
        url: '/movies/' + movie_id + '/ratings/' + rating_id
        type: 'PATCH'
        data: { rating: { score: score } }).done (data) ->

(($) ->
  window.StarRating || (window.StarRating = {})

  StarRating.init = ->
    init_controls()

  StarRating.update_rating = ->
    update_rating()

  init_controls = ->
    overall_rating()
    post_rating()
    update_rating()
).call(this)

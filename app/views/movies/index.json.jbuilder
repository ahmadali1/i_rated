json.array!(@movies) do |movie|
  json.extract! movie, :id, :name, :released_date, :is_featured, :description, :duration, :embedded_video
  json.url movie_url(movie, format: :json)
end

module MoviesHelper
  def fetch_image(image)
    image.object.image.url(:med)
  end

  def collection_for_movie_genre
    Movie::GENRE
  end

end

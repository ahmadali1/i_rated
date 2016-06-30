module MoviesHelper

  def fetch_image(image, size= :med)
    image.image.url(size) unless image.nil?
  end

  def collection_for_movie_genre
    Movie::GENRE
  end

end

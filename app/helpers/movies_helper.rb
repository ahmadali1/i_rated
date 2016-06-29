module MoviesHelper
  def fetch_image(image)
    image.object.image.url(:med)
  end

end

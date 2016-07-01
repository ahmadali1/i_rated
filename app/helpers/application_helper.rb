module ApplicationHelper

  def show_image(image, size= :med)
    unless image.nil?
      image.image.url(size)
    end
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  def get_genders
    User::GENDERS
  end

  def fetch_thumbnail(image, size= :small)
    unless image.nil?
      return image.image.url(size)
    end
    image_url("noimg.png")
  end

end

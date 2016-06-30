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

end

module ApplicationHelper

  def show_image(user)
    if user.image
      user.image.url(:large)
    end
  end

end

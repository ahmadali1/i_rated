module ActiveAdmin::ViewsHelper

  def attachment_image(attachment)
    attachment.object.image.url(:small) unless attachment.object.new_record?
  end

end

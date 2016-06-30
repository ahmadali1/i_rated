module DeviseHelper

  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map{ |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h4>Errors</h4>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def get_resource_email(resource)
    resource.pending_reconfirmation? ? resource.unconfirmed_email : resource.email
  end

end

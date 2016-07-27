class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender, image_attributes: :image) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :current_password, :password, :password_confirmation, :first_name, :last_name, :gender, image_attributes: [:id, :image]) }
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def valid_date_range(params)
    return if params[:start_date].blank? && params[:end_date].blank?
    if (params[:start_date].blank? && params[:end_date].present?) || (params[:start_date].present? && params[:end_date].blank?)
      'Both dates should be present'
    elsif !valid_date_format?(params[:start_date]) || !valid_date_format?(params[:end_date])
      'Please provide a valid date'
    elsif params[:start_date].to_date > params[:end_date].to_date
      'End date should be after start date'
    end
  end

  def valid_date_format?(date)
    date.to_date rescue false
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

end

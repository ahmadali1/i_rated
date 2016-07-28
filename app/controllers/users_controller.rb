class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @title = current_user.first_name
    @favourite_movies = current_user.favourite_movies.page(params[:page]).per Movie::FAVOURITE_PER
  end

end

class PagesController < ApplicationController

  before_action :authenticate_user!

  def home
    @latest_movies = Movie.get_latest_movies
    @featured_movies = Movie.get_featured_movies
  end

end

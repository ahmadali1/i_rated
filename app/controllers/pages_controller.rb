class PagesController < ApplicationController

  def home
    @latest_movies = Movie.get_latest_movies
    @featured_movies = Movie.get_featured_movies
  end

end

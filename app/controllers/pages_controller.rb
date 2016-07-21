class PagesController < ApplicationController

  def home
    @latest_movies = Movie.get_latest_movies
    @featured_movies = Movie.get_featured_movies
    @top_movies = Movie.top.limit(Movie::HOME_MOVIES_LIMIT)
  end

end

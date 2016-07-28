class PagesController < ApplicationController

  def home
    movie = Movie.includes(:images)
    @latest_movies = movie.get_latest_movies
    @featured_movies = movie.get_featured_movies
    @top_movies = movie.top.limit(Movie::HOME_MOVIES_LIMIT)
  end

end

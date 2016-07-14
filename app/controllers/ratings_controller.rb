class RatingsController < ApplicationController

  before_action :set_rating, only: [:update]
  before_action :set_movie, only: [:create, :update]
  before_action :authenticate_user!, only: [:create, :update]

  def create
    @rating = @movie.ratings.create(score: rating_params[:score], user: current_user)

    respond_to do |format|
      if @rating.save
        set_user_ratings
        flash.now[:success] = "Rating successfully created"
        format.js
      else
        flash.now[:error] = @ratings.errors
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update_attribute(:score, rating_params[:score])
        set_user_ratings
        flash.now[:success] = "Rating successfully updated"
        format.js
      else
        flash.now[:error] = "Rating is not updated due to an error"
        format.js
      end
    end
  end

  private
    def set_rating
      @rating = Rating.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def rating_params
      params.require(:rating).permit(:score)
    end

    def set_user_ratings
      @user_movie_rating = @movie.movie_ratings(current_user)
    end
end

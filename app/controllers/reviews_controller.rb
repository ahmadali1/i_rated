class ReviewsController < ApplicationController

  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_movie
  before_action :validates_review_user, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def edit
  end

  def create
    @review = @movie.reviews.create(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @movie, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
        flash.now[:success] = 'Review was successfully created.'
      else
        flash.now[:error] = @review.errors.full_messages
      end
      format.js
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @movie, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def validates_review_user
      unless @review.user.id == current_user.id
        return redirect_to @movie, alert: 'Not Authorized'
      end
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:comment)
    end
end

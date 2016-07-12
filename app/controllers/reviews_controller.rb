class ReviewsController < ApplicationController

  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_movie
  before_action :validates_review_user, only: [:edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = @movie.reviews.create(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @movie, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
        flash.now[:success] = 'Review was successfully created.'
        format.js
      else
        flash.now[:error] = @review.errors.full_messages
        format.js
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
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

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def validates_review_user
      if @review.user.id != current_user.id
        flash[:errors] = 'Not Authorized'
        return redirect_to @movie   
      end
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment)
    end
end

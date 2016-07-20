class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :favourite_movie]
  before_action :get_actors
  before_action :authenticate_user!, except: [:show, :index]
  before_action :already_favourite_movie, only: :favourite_movie
  # GET /movies
  # GET /movies.json
  def index
    @movies =
      if params[:search].present?
        Movie.search(params[:search]).latest_first.approved_movies.page(params[:page]).per(Movie::SEARCHED_PER)
      else
        Movie.get_movies(params).page(params[:page])
      end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @reviews = @movie.reviews.includes(:user).latest
    @review = @movie.reviews.build
    @user_movie_rating = @movie.movie_ratings(current_user)
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    @selected = @movie.actors.pluck(:id)
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def favourite_movie
    if @movie.create_favourite(params, current_user)
      flash[:success] = 'This movie has been added to favourite movies'
    else
      flash[:error] = @movie.errors
    end
    respond_to do |format|
     format.html { redirect_to @movie }
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_actors
    @all_actors = Actor.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :released_date, :description, :duration, :embedded_video, :genre, actor_ids: [], images_attributes: [:id, :image, :_destroy])
    end

    def already_favourite_movie
      if FavouriteMovie.already_favourite?(@movie, current_user)
        flash[:error] = 'Already added to favourite movies'
        redirect_to movie_path(@movie)
      end
    end

end

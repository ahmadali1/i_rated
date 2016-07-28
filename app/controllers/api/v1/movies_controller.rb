module Api
  module V1
    class MoviesController < ApplicationController
      before_action :validate_date_range, only: :index
      before_action :set_movie, only: :show
      before_action :authenticate_request

      def index
        @movies = Movie.search_movie params
        respond_to do |format|
          format.json { render json: {movies: @movies}, status: 200 }
        end
      end

      def show
        status = if @movie.present?
          200
        else
          404
        end

        respond_to do |format|
          format.json { render json: { movie: @movie.movie_hash(request.env['HTTP_HOST']) }, status: status }
        end

      end

      private
        def validate_date_range
          message = valid_date_range(params)
          if message
            respond_to do |format|
              format.json { render json: { Error: message }, status: 400 }
            end
          end
        end

        def set_movie
          @movie = Movie.includes(:reviews, :ratings).find_by_id(params[:id])
        end

        def authenticate_request
          return if request.headers['Authorization'] && request.headers['Authorization'] == User::TOKEN
          head :unauthorized
        end

    end
  end
end

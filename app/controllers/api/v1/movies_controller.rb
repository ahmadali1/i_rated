module Api
  module V1
    class MoviesController < ApplicationController
      before_action :validate_date_range, only: :index
      before_action :set_movie, only: :show
      before_action :authenticate_request
      before_action :varify_approval, only: :show
      respond_to :json

      def index
        @movies = Movie.search_movie params
        render json: { movies: @movies }, status: 200
      end

      def show
        render json: { movie: @movie.movie_hash(request.env['HTTP_HOST']) }, status: 200
      end

      private
        def validate_date_range
          message = valid_date_range(params)
          if message
            render json: { Error: message }, status: 400
          end
        end

        def set_movie
          @movie = Movie.includes(:reviews, :ratings).find_by_id(params[:id])
          render json: {}, status: 404 if @movie.blank?
        end

        def authenticate_request
          return if request.headers['Authorization'] && request.headers['Authorization'] == User::TOKEN
          head :unauthorized
        end

        def varify_approval
          message = varify_movie_approval(@movie)
          render json: { error: message }, status: 404 if message
        end

    end
  end
end

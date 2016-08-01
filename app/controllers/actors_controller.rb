class ActorsController < ApplicationController

  before_action :set_actor, only: :show

  def show
    @acted_movies = @actor.movies.page(params[:page]).per Movie::PAGINATE_PER
  end

  private

  def set_actor
    @actor = Actor.find_by_id(params[:id])
    redirect_to root_path, alert: 'Actor does not exists' if @actor.blank?
  end

end

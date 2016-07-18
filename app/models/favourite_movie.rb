class FavouriteMovie < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie

  def self.already_favourite?(user, movie)
    FavouriteMovie.exists?(user: user, movie: movie)
  end

end

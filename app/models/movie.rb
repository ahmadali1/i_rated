class Movie < ActiveRecord::Base

  paginates_per 10
  FAVOURITE_PER = 8
  LATEST_MOVIES_LIMIT = 4
  FEATURED_MOVIES_LIMIT = 4
  GENRE = ["Action", "Horror", "Romance", "Documentary", "Biography", "Comedy", "Crime", "Drama", "Romance", "War"]

  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :movie_casts, dependent: :destroy
  has_many :actors, through: :movie_casts
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

  scope :latest, -> { order(released_date: :desc) }
  scope :featured, -> { where(is_featured: true) }

  validates :name, presence: true, length: { maximum: 60 }
  validates :released_date, presence: true
  validates :duration, length: { maximum: 20 }
  validates :genre, length: { maximum: 30 }
  validates :embedded_video, length: { maximum: 250 }

  def all_movie_actors
    return self.actors.collect(&:name).join(', ')
  end

  def self.get_latest_movies
    self.latest.limit(LATEST_MOVIES_LIMIT);
  end

  def self.get_featured_movies
    self.featured.limit(FEATURED_MOVIES_LIMIT)
  end

  def self.get_movies(movie_params)
    return self.featured if movie_params[:featured].present?
    return self.latest if movie_params[:latest].present?
    return self.all
  end

  def movie_ratings(user)
    self.ratings.where(user: user).first if user.present?
  end

  def available_ratings?(user)
    self.ratings.where(user: user).exists? if user.present?
  end

  def average_rating
    self.ratings.exists ? (self.ratings.average(:score)) : 0
  end

  def movie_cast
    self.actors.pluck(:name).join(', ')
  end

  def first_poster
    self.images.first
  end

  def create_favourite(params, user)
    favourite = self.favourite_movies.new
    favourite.user = user
    favourite.save
  end

end

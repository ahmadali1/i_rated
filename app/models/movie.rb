class Movie < ActiveRecord::Base
  include ThinkingSphinx::Scopes

  FAVOURITE_PER = 8
  HOME_MOVIES_LIMIT = 4
  GENRE = ["Action", "Horror", "Romance", "Documentary", "Biography", "Comedy", "Crime", "Drama", "Romance", "War"]

  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :movie_casts, dependent: :destroy
  has_many :actors, through: :movie_casts
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

  scope :latest, -> { order(released_date: :desc) }
  scope :featured, -> { where(is_featured: true).latest }
  scope :approved, -> { where(approved: true) }
  scope :top, -> { joins(:ratings).group('movie_id').order('AVG(ratings.score) DESC') }

  validates :name, presence: true, length: { maximum: 60 }
  validates :released_date, presence: true
  validates :duration, length: { maximum: 20 }
  validates :genre, length: { maximum: 30 }
  validates :embedded_video, length: { maximum: 250 }

  def self.get_latest_movies
    self.latest.approved.limit(HOME_MOVIES_LIMIT)
  end

  def self.get_featured_movies
    self.featured.approved.limit(HOME_MOVIES_LIMIT)
  end

  def movie_ratings(user)
    self.ratings.where(user: user).first if user.present?
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

  def self.valid_date?(params)
    params[:start_date].present? && params[:end_date].present?
  end

  def self.default_conditions(params)
    default_conditions =
      {
        conditions: {},
        with: {},
        order: 'released_date DESC',
        page: params[:page],
        per_page: 10,
      }
    default_conditions[:conditions][:genre] = params[:genre] if params[:genre].present?
    default_conditions[:conditions][:actor] = params[:actor] if params[:actor].present?
    default_conditions[:conditions][:description] = params[:description] if params[:description].present?
    default_conditions[:with][:released_date] = Date.parse(params[:start_date])..Date.parse(params[:end_date]) if valid_date?(params)
    default_conditions[:with][:approved] = true
    return default_conditions
  end

  def self.search_movie(params)
    self.search params[:search], default_conditions(params)
  end

  def movie_hash
    movie = self.attributes
    movie[:actors] = self.actors.select(:id, :name, :gender, :country)
    movie[:reviews] = self.reviews.select(:id, :user_id, :comment, :created_at, :report_count)
    movie[:ratings] = self.ratings.select(:id, :score,:user_id, :created_at)
    movie
  end

end

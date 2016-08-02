class Movie < ActiveRecord::Base
  include ThinkingSphinx::Scopes

  PAGINATE_PER = 10
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
  scope :sort_by_ratings, -> (direction = 'DESC') { joins('LEFT OUTER JOIN ratings ON movies.id = ratings.movie_id').group('movies.id').order('AVG(ratings.score) ' + direction) }

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

  def self.get_movies(movie_params)
    movies = self.includes(:images).approved
    movies = movies.featured if movie_params[:featured].present?
    movies = movies.top if movie_params[:top].present?
    movies = movies.latest if movie_params[:latest].present?
    movies = movies.order(movie_params[:sort] + ' ' + movie_params[:direction]) if movie_params[:direction].present? && movie_params[:sort] == 'released_date'
    movies = movies.sort_by_ratings(movie_params[:direction]) if movie_params[:direction].present? && movie_params[:sort] == 'ratings'
    return movies.page(movie_params[:page]).per Movie::PAGINATE_PER
  end

  def self.section_params(params)
    params[:featured] || params[:latest] || params[:top] || params[:sort] || params[:direction]
  end

  def self.search_movie(params)
    return self.get_movies(params) if section_params(params)
    self.search params[:search], default_conditions(params)
  end

  def movie_hash(base_url)
    movie = self.attributes
    movie_posters = []
    movie[:posters] = self.images.collect { |attachment| [base_url, attachment.image.url(:large)].join }
    movie[:actors] = self.actors.select(:id, :name, :gender, :country)
    movie[:reviews] = self.reviews.select(:id, :user_id, :comment, :created_at, :report_count)
    movie[:ratings] = self.ratings.select(:id, :score,:user_id, :created_at)
    movie
  end

end

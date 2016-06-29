class Actor < ActiveRecord::Base

  has_many :movie_casts
  has_many :movies, through: :movie_casts
  has_one :image, as: :imageable

  validates :name, presence: true, length: { maximum: 60 }
  validates :country, length: { maximum: 20 }
  validates :gender, length: { maximum: 10 }
  validates :date_of_birth, length: { maximum: 20 }

end

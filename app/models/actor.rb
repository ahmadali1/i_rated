class Actor < ActiveRecord::Base

  has_many :movie_casts, dependent: :destroy
  has_many :movies, through: :movie_casts
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 60 }
  validates :country, length: { maximum: 20 }
  validates :gender, length: { maximum: 10 }, inclusion: { in: User::GENDERS, if: 'gender.present?' }
  validates :date_of_birth, length: { maximum: 20 }
  validates :biography, length: { maximum: 2000 }

end

class User < ActiveRecord::Base
  TOKEN = "dXNlcm5hbWU6YXNkZmFzZGY="
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :report_reviews, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 60 }
  validates :last_name, presence: true, length: { maximum: 60 }

  GENDERS = ["Male", "Female"]

end

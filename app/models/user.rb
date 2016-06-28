class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image

  validates :first_name, presence: true, length: { maximum: 60 }
  validates :last_name, presence: true, length: { maximum: 60 }

  GENDERS = ["Male", "Female"]

  def get_image
    return self.image if self.image.present?
    return self.build_image
  end

end

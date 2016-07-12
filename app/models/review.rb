class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 2000 }

  scope :latest, -> { order('created_at DESC') }

  def get_username
    self.user.first_name
  end

end

class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  has_many :report_reviews, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 2000 }

  scope :latest, -> { order('created_at DESC') }

  def get_username
    self.user.first_name
  end

  def has_report?(user)
    self.report_count > 0
  end

end

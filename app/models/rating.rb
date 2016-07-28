class Rating < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie

  validates :score, inclusion: { in: 0..5 }, presence: true

end

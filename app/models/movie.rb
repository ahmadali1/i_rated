class Movie < ActiveRecord::Base

validates :name, presence: true, length: { maximum: 60 }
validates :released_date, presence: true
validates :is_featured, presence: true
validates :duration, length: { maximum: 20 }

end

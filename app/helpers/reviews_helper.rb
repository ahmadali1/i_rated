module ReviewsHelper

  def is_review_owner?(review, user)
    review.user == user
  end

end

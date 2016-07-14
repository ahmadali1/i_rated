module ReportReviewHelper

  def already_reported_class(review)
    return 'disabled' if review.has_report?(current_user)
  end

end

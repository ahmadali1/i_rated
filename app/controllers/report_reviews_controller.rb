class ReportReviewsController < ApplicationController

  before_action :set_report_review, only: [:destroy]
  before_action :find_review
  before_action :authenticate_user!

  def create
    if @review.has_report?(current_user)
      flash.now[:error] = 'Already reported'
    else
      @report_review = @review.report_reviews.build(user: current_user)
      if @report_review.save
        flash.now[:success] = 'Reported successfully'
      else
        flash.now[:error] = @report_review.errors
      end
    end
  end

  def destroy
    @report_review.destroy if @report_review
  end

private
  def set_report_review
    @report_review = ReportReview.find(params[:id])
  end

  def find_review
    @review = Review.find(params[:review_id])
  end

end

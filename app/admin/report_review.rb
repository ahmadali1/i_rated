ActiveAdmin.register ReportReview do

  actions :index, :destroy

  menu label: "Reported-Reviews"

  filter :user, as: :select, collection: User.pluck(:email, :id)
  filter :review_id, as: :select, collection: Review.pluck(:id)

  index do
    column :id
    column :user_id
    column :review_id
    actions
  end

end

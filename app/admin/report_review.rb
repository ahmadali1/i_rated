ActiveAdmin.register ReportReview do

  actions :index, :destroy

  menu label: "Reported-Reviews"

  index do
    column :id
    column :user_id
    column :review_id
    actions
  end

end

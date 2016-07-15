ActiveAdmin.register Review do

  permit_params :user_id, :movie_id, :comment

  filter :user, as: :select, collection: User.pluck(:email, :id)
  filter :report_count
  filter :comment
  filter :movie
  filter :created_at

  index do
    column :id
    column :movie_id
    column :comment
    column :report_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: User.pluck(:email, :id)
      f.input :movie
      f.input :comment
    end
    f.actions
  end

end

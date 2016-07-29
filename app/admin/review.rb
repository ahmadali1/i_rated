ActiveAdmin.register Review do

  permit_params :user_id, :movie_id, :comment

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
      f.input :movie
      f.input :comment
    end
    f.actions
  end

end

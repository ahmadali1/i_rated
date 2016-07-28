ActiveAdmin.register User do

  permit_params :first_name, :gender, :last_name, :email, :password

  filter :first_name
  filter :last_name
  filter :email
  filter :gender
  filter :created_at

  index do
    column :first_name
    column :last_name
    column :email
    column :created_at
    column "Images" do |movie|
      image_tag(movie.image.image.url(:small)) if movie.image
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :gender, as: :select, collection: User::GENDERS
    end
    f.actions
  end

end

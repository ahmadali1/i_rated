ActiveAdmin.register Actor do

  permit_params :name, :age, :country, :gender, :date_of_birth

  filter :movie
  filter :name
  filter :age
  filter :country
  filter :gender
  filter :date_of_birth

  form do |f|
    f.inputs do
      f.input :name
      f.input :age
      f.input :country
      f.input :gender, as: :select, collection: User::GENDERS
      f.input :date_of_birth
    end
    f.actions
  end

end

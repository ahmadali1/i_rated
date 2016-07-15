ActiveAdmin.register Actor do

  permit_params :name, :age, :country, :gender, :date_of_birth

  filter :movie
  filter :name
  filter :age
  filter :country
  filter :gender
  filter :date_of_birth

end

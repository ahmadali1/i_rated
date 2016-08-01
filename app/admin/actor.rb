ActiveAdmin.register Actor do

  permit_params :name, :age, :country, :gender, :date_of_birth, images_attributes: [:id, :image, :_destroy]

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
      f.has_many :images, heading: 'Images', new_record: 'Add Image' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment_image attachment), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Image'
      end
    end
    f.actions
  end

  index do
    column :name
    column :country
    column :age
    column :gender
    column :date_of_birth
    column "Image" do |movie|
      div do
        image_tag(movie.images.first.image.url(:small)) if movie.images.first.present?
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :country
      row :age
      row :gender
      row :date_of_birth
      row "Images" do |movie|
        div do
          movie.images.each do |attachment|
            div do
              image_tag(fetch_thumbnail(attachment, :med))
            end
          end
        end
      end
    end
  end

end

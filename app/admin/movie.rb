ActiveAdmin.register Movie do

  permit_params :name, :description, :embedded_video, :genre, :approved, {actor_ids: []}, :is_featured, images_attributes: [:id, :image, :_destroy]

  filter :name
  filter :description
  filter :report_count
  filter :actors do |movie|
    movie.movie_cast
  end
  filter :is_featured
  filter :genre
  filter :created_at
  filter :approved

  index do
    column :name
    column :description
    column :is_featured
    column :approved
    column :actors do |movie|
      movie.movie_cast
    end
    column "Image" do |movie|
      div do
        image_tag(movie.first_poster.image.url(:small)) if movie.first_poster.present?
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :embeded_url
      row :featured
      row :genre
      row :approved
      row :actors do |movie|
        movie.movie_cast
      end
      row "Image" do |movie|
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

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :embedded_video
      f.input :is_featured
      f.input :approved
      f.input :actors
      f.input :genre, as: :select, collection: Movie::GENRE
      f.has_many :images, heading: 'Posters', new_record: 'Add Poster' do |attachment|
        attachment.input :image, hint: attachment.template.image_tag(attachment_image attachment), allow_destroy: true
        attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
      end
    end
    f.actions
  end

end

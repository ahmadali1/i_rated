class Image < ActiveRecord::Base

  belongs_to :imageable, polymorphic: true

  has_attached_file :image, styles: { small: "64x64", med: "300x300", large: "500x500" }, default_url: ':style/missing.png'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image

end

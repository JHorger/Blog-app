require 'paperclip'
require 'pry'

class Picture < ApplicationRecord
  belongs_to :article

  validates :picture_file_name, presence: true
  validates :picture_content_type, presence: true
  validates :picture_file_size, presence: true
  validates :picture_updated_at, presence: true


  has_attached_file :picture,
    dependent: :destroy, 
    styles: { original: "300x300>", thumb: "100x100>"}, 
    path: "/pictures/:id/:style/:filename",
    source_file_options: {all: "-auto-orient"}
  validates :article, presence: true
  validates_attachment :picture,
    content_type: {content_type: ["image/jpeg", "image/gif", "image/png"]},
    presence: true
  

  # validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  # validates_presence_of :picture
  # validates :picture_size_validation
  # mount_uploader :picture, PictureUploader

  # def picture
  #   return unless article.picture.attached?

  #   picture.blob.attributes
  #   .slice('filename', 'byte-size', 'id')
  #   .merge(url: picture_url(picture))
  # end

  # def picture_url
  #   rails_blob_path(picture, only_path: true)
  # end

  # private
  # def picture_size_validation
  #   errors[:picture] << "should be less than 1 MB" if image.size > 1.megabytes
  # end
end

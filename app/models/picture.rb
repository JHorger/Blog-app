require 'paperclip'

class Picture < ApplicationRecord
  belongs_to :article

  validates_processing_of :picture
  validates :picture_size_validation
  validates :picture_file_name, presence: true
  validates :picture_content_type, presence: true
  validates :picture_file_size, presence: true
  validates :picture_updated_at
  mount_uploader :picture, PictureUploader
  

  def picture
    return unless article.picture.attached?

    picture.blob.attributes
    .slice('filename', 'byte-size', 'id')
    .merge(url: picture_url(picture))
  end

  def picture_url
    rails_blob_path(picture, only_path: true)
  end

  private
  def picture_size_validation
    errors[:picture] << "should be less than 1 MB" if image.size > 1.megabytes
  end
end

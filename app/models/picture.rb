class Picture < ApplicationRecord
  belongs_to :article

  def picture
    return unless article.picture.attached?

    picture.blob.attributes
    .slice('filename', 'byte-size', 'id')
    .merge(url: picture_url(picture))
  end

  def picture_url
    rails_blob_path(picture, only_path: true)
  end
end

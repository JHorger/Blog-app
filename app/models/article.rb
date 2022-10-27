require 'paperclip'

class Article < ApplicationRecord
    include Visible

    has_many :comments, dependent: :destroy
    has_one_attached :picture do |attachable|
        attachable.variant :thumb, resize_to_limit: [100, 100]
    end
    
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }




    # validates_with AttachmentSizeValidator, attributes: :picture, less_than: 1.megabytes
    # has_attached_file :picture, dependent: :destroy, styles: { medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
    # validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
    attr_accessor :picture

    # def picture
    #     return unless @article.picture_id.nil?

    #     picture.blob.attributes
    #     .slice('filename', 'byte-size', 'id')
    #     .merge(url: picture_url(picture))
    # end

    # def picture_url
    #     rails_blob_path(picture, only_path: true)
    # end
end

require 'paperclip'
require 'pry'
require 'aws-sdk-s3'
class Picture < ApplicationRecord
  belongs_to :article

  validates :picture_file_name, presence: true
  validates :picture_content_type, presence: true
  validates :picture_file_size, presence: true
  validates :picture_updated_at, presence: true
  attr_accessor :picture

  has_attached_file :picture,
    dependent: :destroy, 
    styles: { original: "300x300>", thumb: "100x100>"}, 
    path: "/pictures/:id/:style/:filename",
    source_file_options: {all: "-auto-orient"},
    :storage => :s3,
    :s3_credentials => Proc.new{|a| a.instance.s3_credentials}

  validates_attachment :picture,
    content_type: {content_type: ["image/jpeg", "image/gif", "image/png"]},
    presence: true
  
  def s3_credentials
    {:bucket => ENV['S3_BUCKET'], :access_key_id => ENV['ACCESS_KEY'], :secret_access_key => ENV['SECRET_ACCESS_KEY']}
  end

  def initialize(picture)
    @picture = picture
  end

  def upload_file(picture_url)
    @picture.upload_file(picture_url)
    true
  rescue Aws::Errors::ServiceError => e
    puts "Couldn't put this picture in the bucket"
    false
  end
  




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

  # private
  # def picture_size_validation
  #   errors[:picture] << "should be less than 1 MB" if image.size > 1.megabytes
  # end
end

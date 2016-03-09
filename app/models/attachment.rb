class Attachment < ActiveRecord::Base
  belongs_to :post

  validates :post, presence: true

  mount_uploader :file, AttachmentUploader
end

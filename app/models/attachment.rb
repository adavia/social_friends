class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  validates :attachable_id, presence: true

  mount_uploader :file, AttachmentUploader
end

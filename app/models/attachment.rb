class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_many :likes, as: :likable, dependent: :destroy

  validates :attachable_id, presence: true

  mount_uploader :file, AttachmentUploader

  default_scope -> { order(created_at: :desc) }
end

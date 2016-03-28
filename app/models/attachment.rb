class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_many :likes, as: :likable, dependent: :destroy

  validates :attachable_id, presence: true

  mount_uploader :file, AttachmentUploader

  default_scope -> { order(created_at: :desc) }

  def make_default!(user)
    Attachment.where(attachable: user).update_all(primary: false)
    update!(primary: true)
  end

  def self.default
    find_by(primary: true)
  end
end

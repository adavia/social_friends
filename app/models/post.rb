class Post < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  has_many :likes, as: :likable, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true

  default_scope -> { order(created_at: :desc) }
end

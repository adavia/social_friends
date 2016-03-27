class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likable, polymorphic: true

  validates :likable, presence: true
  validates :user, presence: true, uniqueness: { scope: [:likable_id, :likable_type] }
end

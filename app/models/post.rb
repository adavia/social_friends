class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }
end

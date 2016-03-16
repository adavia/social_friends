class Profile < ActiveRecord::Base
  belongs_to :user

  validates :location, presence: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: %w(male female),
    message: "%{value} is not a valid gender" }
  validates :birthday, presence: true
  validate  :birthday_cannot_be_greater_than_today

  def birthday_cannot_be_greater_than_today
    if birthday > Time.now
      errors.add(:birthday, "can't be greater than current date")
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :subscriptions, foreign_key: :follower_id,
  	dependent: :destroy
	has_many :leaders, through: :subscriptions

	has_many :reverse_subscriptions, foreign_key: :leader_id,
		class_name: 'Subscription', dependent: :destroy
	has_many :followers, through: :reverse_subscriptions

	has_many :posts, dependent: :destroy

  has_many :attachments, as: :attachable, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 5 }

  def to_s
    username
  end

  def timeline_user_ids
    leader_ids + [id]
  end

	def following?(leader)
		leaders.include? leader
	end

	def follow!(leader)
		if leader != self && !following?(leader)
			leaders << leader
		end
	end

  def unfollow!(leader)
    if leader != self && following?(leader)
      leaders.delete(leader)
    end
  end
end

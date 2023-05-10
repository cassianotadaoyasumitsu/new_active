class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  validates :first_name, :last_name, :furigana, :gender, :phone, :postal_code, :address, :job, presence: true
  # validates :role, :status, presence: true, if: :persisted?
  # validate :role_required_for_active_user, if: :persisted?
  validate :active_user_must_have_followers, if: Proc.new { |user| user.status == 'active' }

  # Collection of Jobs
  # JOBS = Job.pluck(:title)

  def role_required_for_active_user
    if status != 'inactive' && role.blank?
      errors.add(:role, "can't be blank for active users")
    end
  end

  # Follow methods:
  def active_user_must_have_followers
    errors.add(:base, "An active user must have at least one follower") if followers.empty?
  end
  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def is_following?(user_id)
    relationship = Follow.find_by(follower_id: id, following_id: user_id)
    true if relationship
  end
end

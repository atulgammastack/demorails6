class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, ->(user) { unscope(:where).where(user: user).or(where(friend: user)) }
  has_one_attached :profile_picture

  validates :first_name, length: { minimum: 3 }
  validates :first_name, :email, :username, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: { case_sensitive: true }
  
  def like_post(post)
    likes.find_by(post_id: post.id)
  end

  def is_friend?(user)
    friendship_for(user)&.confirmed
  end

  def friendship_for(user)
    friend_request_for(user) || user.friend_request_for(self)
  end

  def friend_request_for(user)
    friendships.find_by(friend_id: user.id)
  end

end

class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, ->(user) { unscope(:where).where(user: user).or(where(friend: user)) }
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :sent_requests, -> { where(confirmed: false) }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :incoming_friendships, -> { where(confirmed: false) }, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :first_name, length: { minimum: 3 }
  validates :first_name, :email, :username, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: { case_sensitive: true }

  scope :confirmed, -> { where(confirmed: true) }
  scope :pending, -> { where(confirmed: false) }

  def send_password_reset_instructions
    self.password_reset_token = generate_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.reset_password_instructions(self).deliver
  end

  def is_friend?(user)
    if friendship_for(user).present?
      friendship_for(user).confirmed
    end
  end

  def friendship_for(user)
    friend_request_for(user) || user.friend_request_for(self)
  end

  def friend_request_for(user)
    friendships.find_by(friend_id: user.id)
  end

  private
  
  def generate_token
    SecureRandom.urlsafe_base64 
  end
end

class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :first_name, length: { minimum: 3 }
  validates :first_name, :email, :username, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: { case_sensitive: true }

  def send_password_reset_instructions
    self.password_reset_token = generate_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.reset_password_instructions(self).deliver
  end

  private
  
  def generate_token
    SecureRandom.urlsafe_base64 
  end
end

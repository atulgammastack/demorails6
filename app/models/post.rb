class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :content, presence: true

  scope :recent_posts, -> {order(created_at: :desc)}

  def post_like_by_user(user_id)
    self.likes.find_by(user_id: user_id)
  end
end

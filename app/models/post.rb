class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :post_file


  validates :content, presence: true
 
  scope :recent, -> { order(created_at: :desc) }

  def like_by_user(user_id)
    self.likes.find_by(user_id: user_id)
  end
end

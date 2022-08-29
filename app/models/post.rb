class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :ordered_by_most_recent, -> {order(created_at: :desc)}
end

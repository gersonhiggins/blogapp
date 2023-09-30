class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post
  validates_presence_of :content

  has_many :likes, as: :likeable

  def liked_by?(user)
    likes.exists?(user:)
  end

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end

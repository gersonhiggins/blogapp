class Like < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post
  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:post_id] }

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

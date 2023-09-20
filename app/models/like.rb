class Like < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

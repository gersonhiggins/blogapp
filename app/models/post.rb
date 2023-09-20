class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes

  def update_post_counter
    user.update(post_counter: user.posts.count)
  end

  def recent_comments(count)
    comments.order(created_at: :desc).limit(count)
  end
end

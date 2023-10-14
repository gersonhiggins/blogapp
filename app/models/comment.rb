class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post
  validates_presence_of :content

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end

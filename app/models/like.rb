class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_likes_counter

  def as_json(_options = {})
    { author_id:, text:, id: }
  end

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

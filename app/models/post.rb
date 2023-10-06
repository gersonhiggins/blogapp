class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :content, presence: true
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_counter

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def as_json(_options = {})
    { title:, text:, id: }
  end

  private

  def update_post_counter
    user.update(post_counter: user.posts.count)
  end
end

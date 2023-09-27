class User < ApplicationRecord
  validates :name, presence: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  has_many :posts, foreign_key: 'user_id'
  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'

  before_validation :initialize_post_counter, on: :create

  def recent_posts(count)
    posts.order(created_at: :desc).limit(count)
  end

  private

  def initialize_post_counter
    self.post_counter ||= 0
  end
end
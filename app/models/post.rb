class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  after_create :increment_user_post_counter
  after_destroy :decrement_user_post_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  has_many :comments
  has_many :likes

  before_validation :initialize_likes_and_comments_counter, on: :create

  def recent_comments(count)
    comments.order(created_at: :desc).limit(count)
  end

  private

  def increment_user_post_counter
    user.increment!(:post_counter)
  end

  def decrement_user_post_counter
    user.decrement!(:post_counter)
  end

  def initialize_likes_and_comments_counter
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end

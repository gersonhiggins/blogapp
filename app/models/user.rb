class User < ApplicationRecord
    has_many :posts, foreign_key: 'user_id'
    has_many :comments
    has_many :likes

    def recent_posts(count)
      posts.order(created_at: :desc).limit(count)
    end
  end
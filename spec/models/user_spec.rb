require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:post_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should have_many(:posts).with_foreign_key('user_id') }
  it { should have_many(:comments).with_foreign_key('user_id') }
  it { should have_many(:likes).with_foreign_key('user_id') }

  describe '#recent_posts' do
    it 'returns the specified number of recent posts, ordered by creation date' do
      user = create(:user)

      post1 = create(:post, user:, created_at: 1.day.ago)
      post2 = create(:post, user:, created_at: 2.days.ago)
      post3 = create(:post, user:, created_at: 3.days.ago)

      recent_posts = user.recent_posts(2)

      expect(recent_posts).to eq([post1, post2])

      recent_posts = user.recent_posts(3)

      expect(recent_posts).to eq([post1, post2, post3])
    end

    it 'returns all posts if the count is greater than the total number of posts' do
      user = create(:user)
      post1 = create(:post, user:)
      post2 = create(:post, user:)

      recent_posts = user.recent_posts(10)

      expect(recent_posts.sort_by(&:id)).to eq([post1, post2].sort_by(&:id))
    end

    it 'returns an empty array if the user has no posts' do
      user = create(:user)

      recent_posts = user.recent_posts(5)

      expect(recent_posts).to eq([])
    end
  end
end

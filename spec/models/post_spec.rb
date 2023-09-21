require 'rails_helper'

RSpec.describe Post, type: :model do
  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should belong_to(:user).class_name('User').with_foreign_key('user_id') }
  it { should have_many(:comments) }
  it { should have_many(:likes) }

  describe '#update_post_counter' do
    it 'updates the post counter of the associated user' do
      user = create(:user)
      post = create(:post, user:)

      expect { post.update_post_counter }.to change { user.reload.post_counter }.by(1)
    end
  end

  describe '#recent_comments' do
    it 'returns the specified number of recent comments for the post' do
      post = create(:post)
      comment1 = create(:comment, post:, content: 'This is a comment.', created_at: 1.day.ago)
      comment2 = create(:comment, post:, content: 'Another comment.', created_at: 2.days.ago)

      recent_comments = post.recent_comments(1)

      expect(recent_comments).to eq([comment1])

      recent_comments = post.recent_comments(2)

      expect(recent_comments).to eq([comment1, comment2])
    end
  end
end

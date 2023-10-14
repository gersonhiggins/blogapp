require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe '#update_comments_counter' do
    it 'updates the comments counter of the associated post' do
      post = create(:post)
      comment = create(:comment, post:)

      comment.update_comments_counter

      post.reload
      expect(post.comments_counter).to eq(1)
    end
  end
end

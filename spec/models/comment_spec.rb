require 'rails_helper'

RSpec.describe Comment, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:content) }
    end

    describe '#update_comments_counter' do
    it 'updates the comments counter of the associated post' do
      post = create(:post)
      comment = create(:comment, post: post)

      # Call the method to update the comments counter
      comment.update_comments_counter

      # Reload the post to get the latest data from the database
      post.reload
      expect(post.comments_counter).to eq(1)
    end
  end
end
  
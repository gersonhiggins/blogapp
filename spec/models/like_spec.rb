require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post) }
  end

  describe '#update_likes_counter' do
    it 'updates the likes counter of the associated post' do
      post = create(:post)
      like = create(:like, post:)

      like.update_likes_counter

      post.reload
      expect(post.likes_counter).to eq(1)
    end
  end
end

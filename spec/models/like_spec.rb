require 'rails_helper'

RSpec.describe Like, type: :model do
    describe '#update_likes_counter' do
      it 'updates the likes counter of the associated post' do
        post = create(:post)
        like = create(:like, post: post)
        
        # Call the method to update the likes counter
        like.update_likes_counter
  
        # Reload the post to get the latest data from the database
        post.reload
        expect(post.likes_counter).to eq(1)
      end
    end
  end
  
require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:comments) { create_list(:comment, 3, post: post) }
  
    scenario 'displays post information and comments' do
      visit user_post_path(user, post)
  
      expect(page).to have_content(post.title)
      expect(page).to have_content("by #{user.name}")
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}")
      expect(page).to have_content(post.content)
  
      comments.each do |comment|
        expect(page).to have_content(comment.user.name)
        expect(page).to have_content(comment.text)
      end
    end
  end
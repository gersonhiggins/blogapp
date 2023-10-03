require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:post1) { create(:post, user: user) }
  let!(:post2) { create(:post, user: user) }
  let!(:post3) { create(:post, user: user) }
  let!(:comment1) { create(:comment, post: post1 ) }
  let!(:comment2) { create(:comment, post: post2 ) }
  let!(:comment3) { create(:comment, post: post3 ) }

  scenario 'displays user information, posts, and pagination' do
    visit user_posts_path(user)

    expect(page).to have_content('All Posts')
    expect(page).to have_css("img[src*='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts.count}")

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post3.title)

    expect(page).to have_content(post1.content)
    expect(page).to have_content(post2.content)
    expect(page).to have_content(post3.content)

    expect(page).to have_content("First comment: #{post1.comments.first.text if post1.comments.first}")

    expect(page).to have_content("Number of comments: #{post1.comments.count}")
    expect(page).to have_content("Number of comments: #{post2.comments.count}")
    expect(page).to have_content("Number of comments: #{post3.comments.count}")

    expect(page).to have_content("Number of likes: #{post1.likes.count}")
    expect(page).to have_content("Number of likes: #{post2.likes.count}")
    expect(page).to have_content("Number of likes: #{post3.likes.count}")

    click_link post1.title
    expect(current_path).to eq(user_post_path(user, post1))
  end
end
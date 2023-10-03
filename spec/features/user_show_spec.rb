require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let!(:user) { create(:user) }
  let!(:post1) { create(:post, user:) }
  let!(:post2) { create(:post, user:) }
  let!(:post3) { create(:post, user:) }

  scenario 'displays user information and posts' do
    visit user_path(user)

    expect(page).to have_css("img[src*='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts.count}")
    expect(page).to have_content(user.bio)

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post3.title)

    expect(page).to have_button('See All Posts')
    click_button('See All Posts')
    expect(current_path).to eq(user_posts_path(user_id: user.id))

    click_link(post1.title)
    expect(current_path).to eq(user_post_path(post1, user_id: user.id))
  end
end

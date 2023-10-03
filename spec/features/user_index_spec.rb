require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let!(:user1) { create(:user, id: 1, name: 'Tom', photo: 'path/to/photo.jpg') }
  let!(:user2) { create(:user, id: 2, name: 'lili', photo: 'path/to/photo.jpg') }

  scenario 'displays username, profile picture, and post count for each user' do
    visit users_path

    expect(page).to have_content(user1.name)
    expect(page).to have_css("img[src*='#{user1.photo}']")
    expect(page).to have_content("Number of posts: #{user1.posts.count}")

    expect(page).to have_content(user2.name)
    expect(page).to have_css("img[src*='#{user2.photo}']")
    expect(page).to have_content("Number of posts: #{user2.posts.count}")
  end

  scenario 'redirects to user show page when clicking on a user' do
    visit users_path

    click_link(user1.name)
    expect(current_path).to eq(user_path(user1))
  end
end

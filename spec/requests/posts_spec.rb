require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user:) }

  describe 'GET /users/:user_id/posts' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'includes placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include("All Posts by #{user.name}")
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'includes placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('HolaPost Title 3')
    end
  end
end

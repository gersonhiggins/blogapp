class PostsController < ApplicationController
  # Action for listing all posts by a user
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  # Action for displaying a single post
  def show
    @post = Post.find(params[:id])
  end
end

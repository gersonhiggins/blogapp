class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :load_posts, only: [:index]

  def index
    @posts = @user.posts.includes(:comments, :likes).page(params[:page]).per(3)
  end

  def create
    @post = @user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      flash.now[:alert] = 'Post creation failed!'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    authorize! :delete, @post

    @post.destroy
    redirect_to user_posts_path(@user, @post), notice: 'Post was successfully deleted.'
  end

  def show
    @post = @user.posts.includes(:comments).find(params[:id])
    @next_post = @user.posts.where('id > ?', @post.id).first
    @prev_post = @user.posts.where('id < ?', @post.id).last
  end

  def new
    @post = @user.posts.build
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def load_posts
    @posts = @user.posts.includes(:comments, :likes).page(params[:page]).per(3)
  end
end

class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def create
    @user = current_user # Fetch the first user

    # Build the post for that user using the post_params
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

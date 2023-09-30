class CommentsController < ApplicationController
  def new
    @user = current_user # Set the current user
    @post = Post.find(params[:post_id]) # Set the post for this comment
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @user = current_user

    if @comment.save
      redirect_to user_post_path(@post.user, @post), notice: 'Comment was successfully created.'
    else
      redirect_to user_post_path(@post.user, @post), alert: 'Error creating comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :content)
  end
end

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to user_post_path(@post.user, @post), notice: 'Comment was successfully created.'
    else
      redirect_to user_post_path(@post.user, @post), alert: 'Error creating comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

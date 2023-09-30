class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.build(user: current_user)

    if like.save
      redirect_to user_post_path(@post.user, @post), notice: 'Post liked!'
    else
      redirect_to user_post_path(@post.user, @post), alert: 'Error liking the post.'
    end
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type).merge(user_id: current_user.id)
  end

  def destroy
    likeable = find_likeable
    like = likeable.likes.find_by(user: current_user)

    if like&.destroy
      likeable.update_likes_counter
      flash[:notice] = 'Unliked!'
    else
      flash[:alert] = 'Error unliking.'
    end

    redirect_back fallback_location: root_path
  end
end

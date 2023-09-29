class LikesController < ApplicationController
  include Rails.application.routes.url_helpers

  def create
    likeable = find_likeable
    like = likeable.likes.find_by(user: current_user)

    if like
      redirect_back fallback_location: root_path, alert: 'You have already liked this post.'
    else
      like = likeable.likes.new(user: current_user)
      if like.save
        likeable.update_likes_counter
        redirect_back fallback_location: root_path, notice: 'Liked!'
      else
        redirect_back fallback_location: root_path, alert: 'Error liking the post.'
      end
    end
  end

  def destroy
    likeable = find_likeable
    @like = likeable.likes.find_by(user: current_user)

    if @like.destroy
      likeable.update_likes_counter # Update likes counter
      redirect_back fallback_location: root_path, notice: 'Unliked!'
    else
      redirect_back fallback_location: root_path, alert: 'Error unliking.'
    end
  end

  private

  def find_likeable
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end
end

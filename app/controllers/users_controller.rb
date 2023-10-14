class UsersController < ApplicationController
  # Action for listing all users
  def index
    @users = User.all
  end

  # Action for displaying a single user
  def show
    @user = User.find(params[:id])
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Method to get the current user (first user from the database)
  def current_user
    @current_user ||= User.first
  end

  # Make the current_user method available to views
  helper_method :current_user
end

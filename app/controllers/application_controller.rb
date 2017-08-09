class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def user_not_authorized
    if current_user.present?
      flash[:alert] = "You are not authorized to perfom this action."
      redirect_to(wiki_path)
    else
      flash[:alert] = "You need to sign up to perfom this action."
      redirect_to(new_user_registration_path)
    end
  end
end

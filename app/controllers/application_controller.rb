class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  #after_initialize :after_init

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_init
    return unless new_record?
    self.status = ACTIVE
  end
end

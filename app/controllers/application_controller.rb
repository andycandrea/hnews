class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_writer :current_user

  #Can the following be made more DRY?
  before_action :require_signin
  before_action :require_signout

  private

  def require_signin
    unless signed_in?
      flash[:danger] = 'You must sign in to perform this action'
      redirect_to signin_path
    end
  end

  def require_signout
    if signed_in?
      redirect_to root_path
    end
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.generate_remember_token
    self.current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(User.digest(cookies[:remember_token]))
  end

  def signed_in?
    current_user.present?
  end
  helper_method :signed_in?
end

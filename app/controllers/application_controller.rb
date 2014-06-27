class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_writer :current_user

  private

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

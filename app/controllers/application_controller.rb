class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
#  include SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.generate_remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(User.digest(cookies[:remember_token]))
  end
end

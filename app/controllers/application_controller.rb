class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  attr_writer :current_user

  before_action :store_redirect_url

  private

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:danger] = 'You do not have access to that action'
      redirect_to root_path
    end
  end

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
    self.current_user           = user
    self.current_remember_token = user.generate_token(:remember_token_digest)
  end
  
  def sign_out
    current_user.destroy_remember_token
    
    self.current_user           = nil
    self.current_remember_token = nil
  end

  def current_user
    @current_user ||= if current_remember_token
      User.find_by(remember_token_digest: current_remember_token.digest) 
    end
  end
  helper_method :current_user

  def current_remember_token
    @current_remember_token ||= if cookies[:remember_token].present?
       Token.new(cookies[:remember_token])
    end
  end
  
  def current_remember_token=(new_token) 
    if new_token.nil?
      cookies.delete(:remember_token)
    else
      cookies.permanent[:remember_token] = new_token.value
    end
    
    @current_remember_token = new_token
  end

  def signed_in?
    current_user.present?
  end
  helper_method :signed_in?

  def store_redirect_url
    session[:redirect_url] = request.original_url
  end

  def redirect_url
    session[:redirect_url] || root_path
  end
end

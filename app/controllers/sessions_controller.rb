class SessionsController < ApplicationController
  before_action :require_signin, only: :destroy
  before_action :require_signout, only: [:new, :create]

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.valid?
      sign_in @session.user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def sign_out
    current_user.destroy_remember_token
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def session_params
    params.require(:session).permit(:name, :password)
  end
end

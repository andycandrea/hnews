class SessionsController < ApplicationController
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

  def sign_out
    current_user.update_attribute(:remember_token, nil)
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end

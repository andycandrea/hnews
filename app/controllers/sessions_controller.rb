class SessionsController < ApplicationController
  skip_before_action :store_redirect_url
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

  def session_params
    params.require(:session).permit(:name, :password)
  end
end

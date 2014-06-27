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
      flash.now[:danger]= 'Invalid username or password'
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

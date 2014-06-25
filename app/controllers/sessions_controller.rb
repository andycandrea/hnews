class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
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
end

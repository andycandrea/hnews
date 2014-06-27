class UsersController < ApplicationController
  def new
    if signed_in?
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_to root_path, flash: { success: 'You have successfully been registered with Haxx0r News' }
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

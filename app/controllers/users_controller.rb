class UsersController < ApplicationController
  before_action :require_signout, only: [:new, :create]
  before_action :require_signin, only: [:edit, :update]
  before_action :require_correct_user, only: [:edit, :update]
  
  def new
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = 'Profile successfully updated'
      redirect_to root_path 
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

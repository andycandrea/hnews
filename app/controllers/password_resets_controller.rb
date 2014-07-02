class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])

    if user
      user.send_password_reset
    end
    
    redirect_to root_path, flash: { success: 'Email sent with reset instructions.' }
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to reset_path, flash: { danger: 'Password reset has expired.' }
    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      redirect_to root_path, flash: { success: 'Password has been reset!' }
    else
      render :edit
    end
  end
end

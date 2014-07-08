class PasswordResetsController < ApplicationController
  def new
    @reset = PasswordReset.new
  end

  def create
    @reset = PasswordReset.new(email: params[:password_reset][:email])
    @reset.deliver
    
    redirect_to root_path, flash: { success: 'Email sent with reset instructions.' }
  end

  def edit
    @reset = PasswordReset.new(token: params[:id])
  end

  def update
    @reset = PasswordReset.new(password_reset_params.merge(token: params[:id]))

    if @reset.update_user
      redirect_to root_path, flash: { success: 'Password has been reset!' }
    else
      render :edit
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:password, :password_confirmation)
  end
end

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )
      # debugger
    if @user
      login(@user)
      redirect_to new_user_url
    else
      flash[:errors] = ["user credentials invalid"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:username, :password)
  # end
end

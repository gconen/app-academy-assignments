class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      sign_in(@user)
    end
  end

  def sign_in(@user)
    session[:session_token] = @user.reset_session_token!
  end
end

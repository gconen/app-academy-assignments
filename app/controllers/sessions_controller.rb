class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in!(@user)
      redirect_to subs_url
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid Login"]
      render :new
    end
  end

  def new
    @user = User.new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end

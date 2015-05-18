class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["invalid password user combination"]
      render :new
    end
  end

  def destroy
    log_out
  end
end

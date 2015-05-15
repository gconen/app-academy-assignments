class SessionsController < ApplicationController
  def new
    @email = ""
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user.nil?
      flash.now[:errors] = ["Invalid email/password combination"]
      @email = user_params[:email]
      render :new
    else
      log_in(user)
      redirect_to bands_url
    end
  end

  def destroy
    log_out
    redirect_to :back
  end
end

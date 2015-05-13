class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action :redirect_unless_logged_in, only: [:show]

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
      redirect_to session_url
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    end
  end

  def show
    @sessions = current_user.sessions
    render :show
  end

  def destroy
    logout
    redirect_to :back
  end
end

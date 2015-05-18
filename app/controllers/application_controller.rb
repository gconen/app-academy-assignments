class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token
  end

  def log_out
    user = current_user
    session[:session_token] = nil
    user.reset_session_token
  end
end

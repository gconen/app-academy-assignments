class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out(user = current_user)
    session[:session_token] = nil if user == current_user
    user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def redirect_unless_logged_in
    redirect_to new_session_url unless current_user
  end
end

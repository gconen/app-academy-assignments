class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user


  def current_user
    if @current_user
      return @current_user
    end
    current_session = Session.find_by(session_token: session[:session_token])
    return nil if current_session.nil?
    @current_user = current_session.user
  end

  def sign_in(user)
    session[:session_token] = Session.generate(user)
  end

  def logout
    Session.find_by(session_token: session[:session_token]).destroy
    session[:session_token] = nil
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end

  def redirect_unless_logged_in
    redirect_to new_session_url if current_user.nil?
  end
end

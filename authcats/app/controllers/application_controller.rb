class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    sesh = Session.find_by(session_token: session[:session_token])
    if sesh
      @current_user ||= sesh.user
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end

  # def require_logged_in
  #   redirect_to new_session_url unless logged_in?
  # end

  def require_logged_out
    redirect_to cats_url if logged_in?
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
	helper_method :current_user, :log_in, :logged_in?, :parent_mode?

  def current_user
    @current_user ||= Family.find_by(id: session[:user_id])
  end

  def log_in family
    session[:user_id] = family.id
  end

  def logged_in?
    !!current_user
  end

  def parent_mode?
    flash[:warn] = "Please enter parent mode" unless session[:admin]
    return session[:admin]
  end

  def require_login
    if !current_user
      flash[:error] = "You must be logged in."
      redirect_to :root
    end
  end
end

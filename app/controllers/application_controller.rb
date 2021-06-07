class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end

  def authenticate
    unless logged_in?
      flash[:error] = 'You must be logged in'
      redirect_to session_path # halts request cycle
    end
  end

  def authenticate_guest
    redirect_to root_path if logged_in?
  end
end

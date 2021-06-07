class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]
  before_action :authenticate_guest, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by!(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = 'Wrong email or password'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to session_path, notice: 'Logged out!'
  end
end

class UsersController < ApplicationController
  before_action :authenticate, only: %i[edit update]
  before_action :authenticate_guest, except: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      flash[:success] = 'Article successfully created'
      redirect_to session_path
    else
      flash[:error] = 'Something went wrong'
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.name = params[:user][:name]
    @user.bio = params[:user][:bio]
    @user.image = params[:user][:image]
    @user.email = params[:user][:email]

    if @user.save!

      redirect_back(fallback_location: edit_user_path, notice: 'Settings saved!')
    else
      flash.now[:error] = 'Something went wrong! Your settings has not been saved yet!'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

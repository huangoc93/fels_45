class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new user_params_creation
    if @user.save
      log_in @user
      flash[:success] = "Your account is created successfully"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params_updating
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params_creation
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def user_params_updating
    params.require(:user).permit(:email, :name, :avatar, :password, :password_confirmation)
  end

  def correct_user
    redirect_to root_url unless current_user?(User.find params[:id])
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end

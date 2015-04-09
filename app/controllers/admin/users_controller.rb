class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @users = User.all
  end

  def destroy
    User.find_by_id(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_path
  end
end

class UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all
    elsif current_user.role == "manager"
      @users = User.where(role: nil)
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  def admin_index
    @admins = User.all
  end

  def show
    if current_user.admin? || current_user.role == "manager"
      @user = User.find(params[:id])
    else
      @user = current_user
    end

  end

end
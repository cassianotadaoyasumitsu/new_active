class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      @users = User.all.order(created_at: :desc)
    elsif current_user.role == "manager" || current_user.role == "master"
      @users = User.where(manager: nil).and(User.where(role: nil)).order(created_at: :desc)
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user), notice: "Internal Account created successfully!"
    else
      render :new
    end
  end

  def manager_index
    @users = User.where(manager: current_user.first_name).or(User.where(factory: current_user.factory)).where.not(id: current_user.id).where.not(status: "inactive").order(created_at: :desc)
  end

  def master_index
    @users = User.where(contractor: current_user.first_name).where.not(id: current_user.id).where.not(status: "inactive").order(created_at: :desc)
  end

  def inactive_index
    @users = User.where(status: "inactive")
  end

  def show
    if current_user.admin? || current_user.role == "manager" || current_user.role == "master"
      @user = User.find(params[:id])
    else
      @user = current_user
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if current_user.admin? || current_user.role == "manager"
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "User was successfully updated."
      else
        render :edit
      end
    else
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "User was successfully updated."
      else
        render :edit
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :furigana, :birthday,
     :gender, :nihongo, :postal_code, :address, :address2, :phone, :status,
     :role, :skill, :licenses, :situation, :message, :job, :factory, :manager, :contractor
    )
  end

end
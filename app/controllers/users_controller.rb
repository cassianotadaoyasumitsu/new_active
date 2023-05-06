class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]
  def index
    if current_user.admin?
      @users = User.all.order(created_at: :desc)
    elsif current_user.role == "manager"
      subquery = Follow.where(follower_id: current_user.id).select(:following_id)
      @users = User.where(role: nil).or(User.where(role: '')).where(status: nil).or(User.where(status: '')).order(created_at: :desc)
      .where.not(id: subquery)
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  def active_index
    @users = User.joins(:follower_relationships).where(follower_relationships: { follower_id: current_user.id }).order(created_at: :desc)
  end

  def inactive_index
    @users = User.where(status: "inactive")
  end

  def show
    if current_user.admin? || current_user.role == "manager"
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
          if @user.status == "active"
          redirect_to user_path(@user), notice: "User was successfully updated."
          elsif @user.status == "inactive"
            redirect_to inactive_users_path, notice: "User was successfully updated."
          else
            redirect_to users_path, notice: "User was successfully updated."
          end
        else
          render :edit
        end
      else
        if @user.update(user_params)
          redirect_to user_path(@user), notice: "User was successfully updated."
        else
          render :edit, notice: "User cannot be updated."
        end
      end
  end

  # Follow methods:
  def follow
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_to edit_user_path(@user) }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_to edit_user_path(@user) }
        format.js { render action: :follow }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,
     :last_name,
     :furigana,
     :birthday,
     :gender,
     :nihongo,
     :postal_code,
     :address,
     :address2,
     :phone,
     :status,
     :role,
     :skill,
     :licenses,
     :situation,
     :message,
    )
  end

end
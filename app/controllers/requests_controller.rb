class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def index
    @requests = current_user.requests
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to root_path, notice: "Your request has been created!"
    else
      render :new
    end
  end

  def edit
    @request = Request.find(params[:id])
    @users = User.all
  end

  def update
    @request = Request.find(params[:id])

    # Only add the user to the association if they are not already included
    unless @request.users.include?(current_user)
      @request.users << current_user
    end

    if @request.update(request_params)
      redirect_to root_path, notice: "Request updated."
    else
      render :edit
    end
  end

  private

  def request_params
    params.require(:request).permit(:first_name, :last_name,:address, :phone, :email, :status, user_ids: [])
  end
end

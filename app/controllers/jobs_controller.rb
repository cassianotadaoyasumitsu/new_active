class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin? || current_user.role == "design"
      @jobs = Job.all.order(created_at: :desc)
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  def show
  end

  def new
    if current_user.admin? || current_user.role == "design"
      @job = Job.new
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  def edit
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  private
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :local, :salary, :contractor, :phone, :type_job)
  end
end

class FactoriesController < ApplicationController
  before_action :set_factory, only: [:show, :edit, :update, :destroy]

  def index
    @factories = Factory.all
  end

  def show
  end

  def new
    @factory = Factory.new
  end

  def edit
  end

  def create
    @factory = Factory.new(factory_params)

    if @factory.save
      redirect_to factories_path, notice: 'Factory was successfully created.'
    else
      render :new
    end
  end

  def update
    if @factory.update(factory_params)
      redirect_to factory_path(@factory), notice: 'Factory was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @factory.destroy
    redirect_to factories_path, notice: 'Factory was successfully destroyed.'
  end

  private

  def set_factory
    @factory = Factory.find(params[:id])
  end

  def factory_params
    params.require(:factory).permit(:name, :address, :phone, :fax, :email, :website, :contact_person, :contact_person_phone, :contact_person_email)
  end
end


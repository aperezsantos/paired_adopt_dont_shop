class ApplicationsController < ApplicationController

  def new
    @pets = favorites.all_pets
  end

  def show
    @application = Application.find(params[:id])
  end

  def index
    @pet = Pet.find(params[:id])
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    @pet.adoption_status = "Available"
    @pet.save
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    if params[:requested_pets] == nil
      @pet = Pet.find(params[:pet_id])
      @pet.adoption_status = "Pending"
      @pet.save
      redirect_to "/pets/#{params[:pet_id]}"
    else
      params[:requested_pets].each do |pet_id|
        @pet = Pet.find(pet_id)
        @pet.adoption_status = "Pending"
        @pet.save
      end
    end
  end

  def create
    application = Application.new(application_params)
    if application.save
          params[:adopted_pets].each do |pet|
              adopted_pet = Pet.find(pet)
              adopted_pet.applications << application
              favorites.contents.delete(pet)
          end
        flash[:notice] = "Application Submitted Succesfully"
        redirect_to '/favorites'
    else
        flash[:notice] = "Please fill out application fully before submiting"
        redirect_to '/applications/new'
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end

class ApplicationsController < ApplicationController

  def new
    @pets = favorites.all_pets
  end

  def show
    @application = Application.find(params[:id])
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

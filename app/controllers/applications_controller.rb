class ApplicationsController < ApplicationController

  def new
    @pets = favorites.all_pets
  end

  def create
    application = Application.create(application_params)

      params[:adopted_pets].each do |pet|
        favorites.contents.delete(pet)
      end

    flash[:notice] = "Application Submitted Succesfully"
    redirect_to '/favorites'
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end

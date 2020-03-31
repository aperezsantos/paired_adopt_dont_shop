class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
    # @shelter_id = params[:id]
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def create
    shelter = Shelter.create!(shelter_params)
    redirect_to '/shelters'
  end

  def destroy
    shelter =  Shelter.find(params[:id])
    if shelter.adopted_pet_check == true
      flash[:notice] = "Error: cannot delete shelter with pending adoptions"
      redirect_to "/shelters"
    else
      Shelter.destroy(params[:id])
      redirect_to "/shelters"
    end
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :zip, :state)
  end
end

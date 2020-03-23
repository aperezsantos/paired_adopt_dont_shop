class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show_index
    @shelter_pets = Pet.where(shelter_id: params[:id])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:id]
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create!(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{params[:id]}"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private
  def pet_params
    params.permit(:name, :image, :description, :age, :sex)
  end
end

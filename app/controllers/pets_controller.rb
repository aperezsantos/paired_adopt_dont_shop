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
    pet = shelter.pets.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}/pets.new"
    end
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/pets/#{params[:id]}/edit"
    end

  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.adoption_status == "Pending"
      flash[:notice] = "Error: cannot delete pet with pending adoption"
      redirect_to "/pets/#{pet.id}"
    else
      Pet.destroy(params[:id])
        if favorites.favorite_status(pet.id)
          favorites.remove_pet(pet.id)
        end
      redirect_to "/pets"
    end
  end

  private
  def pet_params
    params.permit(:name, :image, :description, :age, :sex)
  end
end

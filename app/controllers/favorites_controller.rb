class FavoritesController < ApplicationController
  def index

  end

  def update

    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    quantity = favorites.count_of(pet.id)
    flash[:notice] = "Pet has been added to Favorites"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end

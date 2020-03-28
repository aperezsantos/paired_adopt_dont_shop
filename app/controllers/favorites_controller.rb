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

  def destroy
    favorites.contents.delete(params[:id])
    flash[:notice] = "Pet has been removed from Favorites"
    redirect_to "/pets/#{params[:id]}"
  end

  def remove_favorite
    favorites.contents.delete(params[:pet_id])
    flash[:notice] = "Pet has been removed from Favorites"
    redirect_to "/favorites"
  end
end

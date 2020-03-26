class FavoritesController < ApplicationController
  def update

    pet = Pet.find(params[:pet_id])
     # pet_id_str = pet.id.to_s
     # session[:favorites] ||= Hash.new(0)
     # session[:favorites][pet_id_str] ||= 0
     # session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1

    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    quantity = favorites.count_of(pet.id)
    flash[:notice] = "Pet has been added to Favorites"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end

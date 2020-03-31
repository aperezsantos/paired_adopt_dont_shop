class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :address, :city, :state, :zip

  def adopted_pet_check
    self.pets.each do |pet|
      return true if (pet.adoption_status != "Available")
    end
  end
end

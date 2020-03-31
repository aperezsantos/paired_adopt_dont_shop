class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :address, :city, :state, :zip

  def adopted_pet_check
    self.pets.each do |pet|
      return true if (pet.adoption_status != "Available")
    end
  end

  def application_count
    applications = []
    pets.each do |pet|
      pet.applications.each do |application|
        applications << application.id
      end
    end
    return applications.uniq.length
  end

  def average_review_rating
    if self.reviews == []
      return 0
    else
      average_rating = 0.0
        self.reviews.each do |review|
          average_rating += review.rating.to_i
        end
      return (average_rating/reviews.length)
    end
  end
end

require 'rails_helper'

RSpec.describe Favorite do

 describe "#total_count" do
   it "can calculate the total number favorited pets" do
     favorite = Favorite.new({
       1 => 1,
       2 => 1
     })
     expect(favorite.total_count).to eq(2)
   end

   describe "#add_pet" do
    it "adds a pet to its contents" do
      favorite = Favorite.new({})
      favorite.add_pet(1)
      favorite.add_pet(2)

      expect(favorite.contents).to eq({'1' => 1, '2' => 1})
    end

    it "adds a pet that hasn't been added yet" do
      favorite = Favorite.new({})
      favorite.add_pet(1)
      favorite.add_pet(2)
      favorite.add_pet(3)

      expect(favorite.contents).to eq({'1' => 1, '2' => 1, '3' => 1})
    end
  end

  describe "#remove_pet" do
    it "removes a pet from favorites that has been deleted" do
      favorite = Favorite.new({})
      favorite.add_pet(1)
      favorite.remove_pet(1)

      expect(favorite.total_count).to eq(0)
    end
  end

  describe "#count_of" do
    it "returns the count of all pets in favorites" do
      favorite = Favorite.new({})

      expect(favorite.count_of(5)).to eq(0)
    end
  end

  describe "#favorite_status" do
    it "checks whether a pet is a favorite or not" do
      favorite = Favorite.new({})
      favorite.add_pet(1)

      expect(favorite.favorite_status(1)).to eq(true)
      expect(favorite.favorite_status(2)).to eq(false)
    end
  end

  describe "#all_pets" do
    it "iterates over favorites storing unique pet ids in an array" do
      favorite = Favorite.new({})
      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
      pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
      pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")
      favorite.add_pet(pet1.id)
      favorite.add_pet(pet2.id)
      
      expect(favorite.all_pets).to eq([pet1, pet2])
    end
  end
 end
end

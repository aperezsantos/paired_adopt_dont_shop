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

  describe "#count_of" do
    it "returns the count of all pets in favorites" do
      favorite = Favorite.new({})

      expect(favorite.count_of(5)).to eq(0)
    end
  end
 end
end

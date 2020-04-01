require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'relationships' do
      it {should have_many :pets}
      it {should have_many :reviews}
  end

  describe "#adopted_pet_check" do
    it "returns true if any of the shelters pets are not available" do
      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
      pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png", adoption_status: "Pending")

      expect(shelter1.adopted_pet_check).to eq(true)
    end
  end

  describe "#application_count" do
    it "returns the number of applications for the shelter" do
      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
      pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
      pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")
      application1 = Application.create!(name: "Jimbo", address: "test address", city: "test city", state: "test state", zip: "test zipcode", phone_number: "test phone number", description: "test description")
      application1.pets << pet1
      application1.pets << pet2
      expect(shelter1.application_count).to eq(1)
    end
  end

  describe "#average_review_rating" do
    it "returns the average review rating for a shelter" do
      shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
      expect(shelter1.average_review_rating).to eq(0)
      review1 = shelter1.reviews.create!(title: "This place is great", rating: "5", content:"wow good lizards", image: "https://c7.alamy.com/comp/XAABRH/guy-with-thumbs-up-XAABRH.jpg")
      review2 = shelter1.reviews.create!(title: "Only lizards wtf", rating: "1", content:"I wanted a dog", image: "https://c7.alamy.com/comp/XAABRH/guy-with-thumbs-up-XAABRH.jpg")
      expect(shelter1.average_review_rating).to eq(3)
    end
  end
end

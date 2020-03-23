# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter1 = Shelter.create!(name: "Larry's Lizards", address: "1331 17th Street", city: 'Denver', state: 'CO', zip: "80202")
shelter2 = Shelter.create!(name: "Ricardo's Reptiles", address: "150 Main Street", city: 'Hershey', state: 'PA', zip: "17033")
pet1 = shelter1.pets.create!(name: "Sam", age: "12", sex: "Female", image: "https://66.media.tumblr.com/6a9b0ea4859319c0defd9681b3a78e8f/tumblr_n8o33kXRnG1qhaglio1_r1_1280.png")
pet2 = shelter1.pets.create!(name: "Melo", age: "3", sex: "Male", image: "https://i.pinimg.com/474x/8f/c4/68/8fc46860f9f52463e4e9db1ec32044f4--hady-reptile-room.jpg")

pet3 = shelter2.pets.create!(name: "Lemmy", age: "3", sex: "Male", image: "https://i.redd.it/ypu5ydssuar21.jpg")
pet4 = shelter2.pets.create!(name: "Hot Stuff", age: "5", sex: "Male", image: "https://pm1.narvii.com/7052/9058c2ef22124550d8f4a57d98f1cbaf0a2d8ac2r1-900-614v2_hq.jpg")

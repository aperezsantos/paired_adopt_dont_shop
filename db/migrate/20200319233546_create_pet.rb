class CreatePet < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :image
      t.string :age
      t.string :sex
      t.string :description
      t.string :adoption_status, default: 'Available'
      t.string :shelter
    end
  end
end

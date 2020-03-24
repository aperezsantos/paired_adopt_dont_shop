class CreateReview < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string:rating
      t.string :content
      t.string :image
    end
  end
end

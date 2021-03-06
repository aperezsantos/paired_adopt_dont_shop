class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def remove_pet(id)
    @contents.delete(id.to_s)
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def favorite_status(id)
    if @contents.keys.include?(id.to_s)
      true
    else
      false
    end
  end

  def all_pets
    pets = []
    @contents.each do |pet_id, value|
      pets << Pet.find(pet_id)
    end
    pets
  end
end

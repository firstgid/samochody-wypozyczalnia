require 'rails_helper'

RSpec.describe Car, type: :model do
  describe "Car - valid values" do
    before do
      @car = Car.new(name: "fiat 126p", description: "stary grat", car_class: "C")
      @polonez = Car.new(name: 'polonez',
                         description: "zailnstalowana instalacja gazowa",
                         car_class: "B")
    end

    it "car.count should be 1, after create" do
      @car.save!
      expect(Car.count).to eq 1
    end

    it "db should be empty" do
      expect(Car.count).to eq 0
    end

    it "name - present, uniqueness" do
      @car.name = ""
      expect(@car.valid?).to be false

      @car.name = @polonez.name
      @car.save!
      expect(@polonez.valid?).to be false
    end

    it "description - present" do
      @car.description = ""
      expect(@car.valid?).to be false

      @car.description = nil
      expect(@car.valid?).to be false

      @car.description = 'poduszka powietrzna'
      expect(@car.valid?).to be true
    end

    it "car_class - present. car_class - wrong/valid value" do
      @car.car_class = ""
      expect(@car.valid?).to be false

      @car.car_class = nil
      expect(@car.valid?).to be false

      @car.car_class = "F"
      expect(@car.valid?).to be false

      @car.car_class = 'a'
      expect(@car.valid?).to be true

      @car.car_class = 'A'
      expect(@car.valid?).to be true

      @car.car_class = 'aAaaaabbbbbbbb'
      expect(@car.valid?).to be false

      @car.car_class = 'b'
      expect(@car.save).to be true

      expect(@car.car_class).to eq 'B'
    end
  end#describe
end

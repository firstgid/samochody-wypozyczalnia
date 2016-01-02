require 'rails_helper'

RSpec.describe Car, type: :model do
  describe "Car - valid values" do
    before do
      @car = Car.new(nazwa: "fiat 126p", opis: "stary grat", klasa: "C")
      @polonez = Car.new(nazwa: 'polonez', opis: "zailnstalowana instalacja gazowa",
                         klasa: "B")
    end

    it "car.count should be 1, after create" do
      @car.save!
      expect(Car.count).to eq 1
    end

    it "db should be empty" do
      expect(Car.count).to eq 0
    end

    it "nazwa - present, uniqueness" do
      @car.nazwa = ""
      expect(@car.valid?).to be false

      @car.nazwa = @polonez.nazwa
      @car.save!
      expect(@polonez.valid?).to be false
    end

    it "opis - present" do
      @car.opis = ""
      expect(@car.valid?).to be false
    end

    it "klasa - present. klasa - wrong/valid value" do
      @car.klasa = ""
      expect(@car.valid?).to be false

      @car.klasa = nil
      expect(@car.valid?).to be false

      @car.klasa = "F"
      expect(@car.valid?).to be false

      @car.klasa = 'a'
      expect(@car.valid?).to be true

      @car.klasa = 'A'
      expect(@car.valid?).to be true

      @car.klasa = 'aAaaaabbbbbbbb'
      expect(@car.valid?).to be false

      @car.klasa = 'b'
      expect(@car.save).to be true

      expect(@car.klasa).to eq 'B'
    end
  end#describe
end

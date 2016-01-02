require 'rails_helper'

RSpec.describe Termin, type: :model do
  before do
    @maluch = Car.new(nazwa: "fiat 126p", opis: "stary grat", klasa: "C")
    @polonez = Car.new(nazwa: 'Polonez Caro', opis: 'posiada instalację gazową', klasa: 'B')
    @mondeo = Car.new(nazwa: 'Ford Mondeo', opis: 'produkcja 2010r., diesel', klasa: 'A')
    @maluch.save!
    @polonez.save!
    @mondeo.save!

    @termin = @polonez.termins.build(
      :osoba => 'Monika Kowalska',
      :data_wyp => Date.current.advance(months: 1),
      :data_odd => Date.current.advance(months: 2))

    @termin2 = @polonez.termins.build(
      :osoba => 'Piotr Wiśnia',
      :data_wyp => @termin[:data_wyp] + 5,
      :data_odd => @termin[:data_odd] + 5)

    @termin3 = @polonez.termins.build(
      :osoba => 'Tomasz Kowal',
      :data_wyp => @termin[:data_wyp] - 5,
      :data_odd => @termin[:data_odd] - 5)

    @termin4 = @polonez.termins.build(
      :osoba => 'Monika Skowronek',
      :data_wyp => @termin[:data_wyp] >> 3,
      :data_odd => @termin[:data_odd] >> 4)

    @termin5 = @polonez.termins.build(
      :osoba => 'Krzysztof Ptak',
      :data_wyp => @termin[:data_wyp] - 5,
      :data_odd => @termin[:data_wyp] - 1)

    @termin6 = @polonez.termins.build(
      :osoba => 'Beata Kot',
      :data_wyp => @termin[:data_odd] + 1,
      :data_odd => @termin[:data_odd] + 1)

    @mal_t1 = @maluch.termins.build(
      :osoba => 'Zbigniew Gitara',
      :data_wyp => Date.current,
      :data_odd => Date.current.advance(:months => 1)
    )

    @mon_t1 = @mondeo.termins.build(
      :osoba => 'Agnieszka Wołyńska',
      :data_wyp => Date.current + 1,
      :data_odd => Date.current + 6
    )
  end

  describe 'Termin overall' do
    it 'other' do
      @termin = @mondeo.termins.build
      expect(@termin.valid?).to be false
      expect(@termin.save).to be false

      car = Car.first.termins.build(:osoba => '', :data_wyp => '', :data_odd => '')
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:data_wyp] = Date.current
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:data_wyp] = ''
      car[:data_odd] = Date.tomorrow
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:data_wyp] = Date.current
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:osoba] = 'Bartosz Wilczek'
      expect(car.valid?).to eq true
      expect(car.save).to eq true
    end

    it 'car cant be borrow if termin is invalid' do
      expect(@termin.save).to be true
      expect(Termin.count).to eq 1

      t = @termin.dup
      expect(t.save).to be false

      expect(@termin2.valid?).to be false
#     @termin2.valid?
#     puts @termin2.errors[:base]
      expect(@termin3.valid?).to be false
      expect(@termin4.save).to be true

      expect(@termin5.valid?).to be true
      @termin5[:data_odd] = @termin5[:data_odd] + 1
      expect(@termin5.valid?).to be false

      expect(@termin6.valid?).to be false
      @termin6[:data_odd] = @termin6[:data_odd] + 1
      expect(@termin6.save).to be true

      @termin2[:data_wyp] = @termin[:data_wyp] + 1
      @termin2[:data_odd] = @termin[:data_odd]
      expect(@termin2.valid?).to be false
      @termin2[:data_odd] = @termin[:data_odd] + 1
      expect(@termin2.valid?).to be false
#     @polonez.termins.each do |t|
#       print t[:osoba], ' ',t[:data_wyp], ' - ', t[:data_odd], "\n"
#     end
    end

    it 'cena is set property' do
      expect(@termin.save).to be true
      cena = @termin[:data_odd] - @termin[:data_wyp]
      cena = cena.to_i * 75
      expect(@termin[:cena]).to eq cena

      expect(@termin4.save).to be true
      cena = @termin4[:data_odd] - @termin4[:data_wyp]
      cena = cena.to_i * 75
      expect(@termin4[:cena]).to eq cena

      expect(@mal_t1.save).to be true
      cena = @mal_t1[:data_odd] - @mal_t1[:data_wyp]
      cena = cena.to_i * 50
      expect(@mal_t1[:cena]).to eq cena

      expect(@mon_t1.save).to be true
      cena = @mon_t1[:data_odd] - @mon_t1[:data_wyp]
      cena = cena.to_i * 100
      expect(@mon_t1[:cena]).to eq cena
    end
  end

  describe 'Termins.car_id' do
    it 'should be integer. Not nil, not < 1, not if car dont exist' do
#     @termin.valid?
#     puts @termin.errors.messages
      @termin[:car_id] = 'x'
      expect(@termin.valid?).to be false

      @termin[:car_id] = nil
      expect(@termin.valid?).to be false

      @termin[:car_id] = -1
      expect(@termin.valid?).to be false

      @termin[:car_id] = 999
      expect(@termin.valid?).to be false
    end
  end

  describe 'termins.data_wyp' do
    it 'not < today, not > than data_odd, not nil, not != Date' do
      @termin[:data_wyp] = Date.current - 1
      expect(@termin.valid?).to be false

      @termin[:data_wyp] = Date.current.advance months: 3
      expect(@termin.valid?).to be false

      @termin[:data_wyp] = nil
      expect(@termin.valid?).to be false

      @termin[:data_wyp] = 999999999990
      expect(@termin.valid?).to be false

      @termin[:data_wyp] = Date.current
      expect(@termin.valid?).to be true
    end
  end

  describe 'termins.data_odd' do
    it 'not nil, not != Date, not < tomorrow' do
      @termin[:data_wyp] = Date.current

      @termin[:data_odd] = nil
      expect(@termin.valid?).to be false

      @termin[:data_odd] = ''
      expect(@termin.valid?).to be false

      @termin[:data_odd] = 999999999990
      expect(@termin.valid?).to be false

      @termin[:data_odd] = Date.current
      expect(@termin.valid?).to be false

      @termin[:data_odd] = Date.tomorrow
      expect(@termin.valid?).to be true
    end
  end

  describe 'termins.osoba' do
    it 'not nil' do
      @termin[:osoba] = nil
      expect(@termin.valid?).to be false

      @termin[:osoba] = ''
      expect(@termin.valid?).to be false
    end
  end
end

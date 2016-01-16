require 'rails_helper'

RSpec.describe Term, type: :model do
  before do
    @maluch = Car.new(name: "fiat 126p", description: "stary grat", car_class: "C")
    @polonez = Car.new(name: 'Polonez Caro',
                       description: 'posiada instalację gazową',
                       car_class: 'B')
    @mondeo = Car.new(name: 'Ford Mondeo', description: 'produkcja 2010r., diesel',
                      car_class: 'A')
    @maluch.save!
    @polonez.save!
    @mondeo.save!

    @termin = @polonez.terms.build(
      :person => 'Monika Kowalska',
      :date_of_rent => Date.current.advance(months: 1),
      :date_of_return => Date.current.advance(months: 2))

    @termin2 = @polonez.terms.build(
      :person => 'Piotr Wiśnia',
      :date_of_rent => @termin[:date_of_rent] + 5,
      :date_of_return => @termin[:date_of_return] + 5)

    @termin3 = @polonez.terms.build(
      :person => 'Tomasz Kowal',
      :date_of_rent => @termin[:date_of_rent] - 5,
      :date_of_return => @termin[:date_of_return] - 5)

    @termin4 = @polonez.terms.build(
      :person => 'Monika Skowronek',
      :date_of_rent => @termin[:date_of_rent] >> 3,
      :date_of_return => @termin[:date_of_return] >> 4)

    @termin5 = @polonez.terms.build(
      :person => 'Krzysztof Ptak',
      :date_of_rent => @termin[:date_of_rent] - 5,
      :date_of_return => @termin[:date_of_rent] - 1)

    @termin6 = @polonez.terms.build(
      :person => 'Beata Kot',
      :date_of_rent => @termin[:date_of_return] + 1,
      :date_of_return => @termin[:date_of_return] + 1)

    @mal_t1 = @maluch.terms.build(
      :person => 'Zbigniew Gitara',
      :date_of_rent => Date.current,
      :date_of_return => Date.current.advance(:months => 1)
    )

    @mon_t1 = @mondeo.terms.build(
      :person => 'Agnieszka Wołyńska',
      :date_of_rent => Date.current + 1,
      :date_of_return => Date.current + 6
    )
  end

  describe 'Termin overall' do
    it 'other' do
      @termin = @mondeo.terms.build
      expect(@termin.valid?).to be false
      expect(@termin.save).to be false

      car = Car.first.terms.build(:person => '', :date_of_rent => '', :date_of_return => '')
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:date_of_rent] = Date.current
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:date_of_rent] = ''
      car[:date_of_return] = Date.tomorrow
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:date_of_rent] = Date.current
      expect(car.valid?).to eq false
      expect(car.save).to eq false

      car[:person] = 'Bartosz Wilczek'
      expect(car.valid?).to eq true
      expect(car.save).to eq true
    end

    it 'car cant be borrow if termin is invalid' do
      expect(@termin.save).to be true
      expect(Term.count).to eq 1

      t = @termin.dup
      expect(t.save).to be false

      expect(@termin2.valid?).to be false
      expect(@termin3.valid?).to be false
      expect(@termin4.save).to be true

      expect(@termin5.valid?).to be true
      @termin5[:date_of_return] = @termin5[:date_of_return] + 1
      expect(@termin5.valid?).to be false

      expect(@termin6.valid?).to be false
      @termin6[:date_of_return] = @termin6[:date_of_return] + 1
      expect(@termin6.save).to be true

      @termin2[:date_of_rent] = @termin[:date_of_rent] + 1
      @termin2[:date_of_return] = @termin[:date_of_return]
      expect(@termin2.valid?).to be false
      @termin2[:date_of_return] = @termin[:date_of_return] + 1
      expect(@termin2.valid?).to be false
#     @polonez.terms.each do |t|
#       print t[:person], ' ',t[:date_of_rent], ' - ', t[:date_of_return], "\n"
#     end
    end

    it 'price is set property' do
      expect(@termin.save).to be true
      price = @termin[:date_of_return] - @termin[:date_of_rent]
      price = price.to_i * 75
      expect(@termin[:price]).to eq price

      expect(@termin4.save).to be true
      price = @termin4[:date_of_return] - @termin4[:date_of_rent]
      price = price.to_i * 75
      expect(@termin4[:price]).to eq price

      expect(@mal_t1.save).to be true
      price = @mal_t1[:date_of_return] - @mal_t1[:date_of_rent]
      price = price.to_i * 50
      expect(@mal_t1[:price]).to eq price

      expect(@mon_t1.save).to be true
      price = @mon_t1[:date_of_return] - @mon_t1[:date_of_rent]
      price = price.to_i * 100
      expect(@mon_t1[:price]).to eq price
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

  describe 'terms.date_of_rent' do
    it 'not < today, not > than date_of_return, not nil, not != Date' do
      @termin[:date_of_rent] = Date.current - 1
      expect(@termin.valid?).to be false

      @termin[:date_of_rent] = Date.current.advance months: 3
      expect(@termin.valid?).to be false

      @termin[:date_of_rent] = nil
      expect(@termin.valid?).to be false

      @termin[:date_of_rent] = 999999999990
      expect(@termin.valid?).to be false

      @termin[:date_of_rent] = Date.current
      expect(@termin.valid?).to be true
    end
  end

  describe 'terms.date_of_return' do
    it 'not nil, not != Date, not < tomorrow' do
      @termin[:date_of_rent] = Date.current

      @termin[:date_of_return] = nil
      expect(@termin.valid?).to be false

      @termin[:date_of_return] = ''
      expect(@termin.valid?).to be false

      @termin[:date_of_return] = 999999999990
      expect(@termin.valid?).to be false

      @termin[:date_of_return] = Date.current
      expect(@termin.valid?).to be false

      @termin[:date_of_return] = Date.current + 2
      expect(@termin.valid?).to be true
    end
  end

  describe 'terms.person' do
    it 'not nil' do
      @termin[:person] = nil
      expect(@termin.valid?).to be false

      @termin[:person] = ''
      expect(@termin.valid?).to be false
    end
  end

end

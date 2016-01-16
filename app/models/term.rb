class Term < ActiveRecord::Base
  require 'unique_ranges_of_dates'

  belongs_to :car
  validates :car_id, :presence => true
  validates :person, :presence => true
  validates :date_of_rent, :date => {after: Proc.new{Date.current - 1},
                                    before: Proc.new{Date.parse('2200-1-1')}}
  validates :date_of_return, :date => {after: Proc.new{Date.current},
                                      before: Proc.new{Date.parse('2200-1-1')}}

# validate :prawidlowa_data

  before_create :set_price
  before_validation :check_proper_dates

  def check_proper_dates
#   begin
    if car_exist?
      car = Car.find_by(:id => self.car_id)
      dates_a = []
      dates_b = []
      if car.terms.size > 0
        car.terms.each do |d|
          dates_a.push d[:date_of_rent]
          dates_b.push d[:date_of_return]
        end
      end
      range = UniqueRangesOfDates.new(dates_a, dates_b)
      unless range.push_range(self.date_of_rent, self.date_of_return)
        errors[:base] = 'niewłaściwy przedział dat'
      end
    end
#   rescue ArgumentError => e
#     errors[:base] = e
#   rescue NoMethodError => e
#     errors[:base] = e
#   end
  end

  def set_price
    self.price = self.date_of_return - self.date_of_rent
    self.price = self.price.to_i
    mnoznik = Car.find_by(:id => self.car_id).car_class
    if mnoznik == 'A'
      self.price *= 100
    elsif mnoznik == 'B'
      self.price *= 75
    else
      self.price *= 50
    end
  end


  private

  # validate :car_id -> x
  # x < 0, doesnt exist car with id = x
  def car_exist?
    id = self.car_id.to_i
    if id <= 0
      errors[:car_id] = 'nieprawidłowy format. Wpisz liczbę większa niz 0'
      false
    elsif Car.find_by(:id => id) == nil
      errors[:car_id] = 'nie ma takiego samochodu!'
      false
    else
      true
    end
  end
end

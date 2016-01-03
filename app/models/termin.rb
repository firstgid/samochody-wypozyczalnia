class Termin < ActiveRecord::Base
  belongs_to :car
  validates :car_id, :presence => true
  validates :osoba, :presence => true
  validates :data_wyp, :date => {after: Proc.new{Date.current - 1}}
  validates :data_odd, :date => {after: Proc.new{Date.current}}

  validate :prawidlowa_data

  before_create :set_cena

  #validate :data_wyp -> x, :data_odd -> y
  # x.class is Date, x > :data_odd
  # y.class is Date
  def prawidlowa_data
    if car_id_exist? && proper_date_format? #skip if car doesnt exist and dates are invalid
      #car = Car.find_by(:id => self.car_id.to_i)
      termins = Termin.where(:car_id => self.car_id)
      if (self.data_wyp <=> self.data_odd) != -1
        errors[:data_wyp] = 'data wypozyczenia musi byc przed data oddania'
      elsif termins.count > 0  #skip if is not termins object
        termins.order :data_wyp
        tfirst = termins.first[:data_wyp]
        tlast = termins.last[:data_odd]

        #skip if data_wyp is before or after all
        if (self.data_wyp < tfirst) && (self.data_odd < tfirst)
          nil
        elsif (self.data_wyp > tlast) && (self.data_odd > tlast)
          nil
        else
          msg = 'samochod zostal wypozyczony w tym okresie'
#         car = car.termins.order(:data_wyp)
          termins.each do |c|
            if (self.data_wyp >= c[:data_wyp]) &&
                  (self.data_wyp <= c[:data_odd])
              errors[:base] = msg
              break;
            elsif (self.data_odd >= c[:data_wyp]) &&
                  (self.data_odd <= c[:data_odd])
              errors[:base] = msg
              break
            elsif (self.data_wyp <= c[:data_wyp]) &&
                  (self.data_odd >= c[:data_odd])
              errors[:base] = msg
              break
            end
          end#each
        end
      end
    end
  end

  def set_cena
    self.cena = self.data_odd - self.data_wyp
    self.cena = self.cena.to_i
    mnoznik = Car.find_by(:id => self.car_id).klasa
    if mnoznik == 'A'
      self.cena = self.cena * 100
    elsif mnoznik == 'B'
      self.cena = self.cena * 75
    else
      self.cena = self.cena * 50
    end
  end


  private

  # validate :car_id -> x
  # x < 0, doesnt exist car with id = x
  def car_id_exist?
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

  def proper_date_format?
    if (self.data_wyp.class != Date) || (self.data_odd.class != Date)
      errors[:base] = 'nieprawidlowy format daty' unless errors[:base].any?
      false
    else
      true
    end
  end
end

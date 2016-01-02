class Car < ActiveRecord::Base
  has_many :termins, :dependent => :destroy
  validates :nazwa, :presence => true, :uniqueness => {case_sensitive: false},
                    :length => {minimum: 3}
  validates :opis, :presence => true
  validates :klasa, :presence => true, :inclusion => {in: ['A', 'B', 'C']}

# before_save {self.klasa = klasa.upcase}
  before_validation  do
    if(self.klasa.class == String)
      self.klasa = klasa.upcase
    end
  end
end

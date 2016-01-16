class Car < ActiveRecord::Base
  has_many :terms, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => {case_sensitive: false},
                    :length => {minimum: 3}
  validates :description, :presence => true
  validates :car_class, :presence => true, :inclusion => {in: ['A', 'B', 'C']}

  before_validation  do
    if(self.car_class.class == String)
      self.car_class = car_class.upcase
    end
  end
end

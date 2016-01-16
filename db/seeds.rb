# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Car.create!([
  {:name => 'Fiat 126p', :description => '15-letni maluch', :car_class => 'C'},
  {:name => 'Daewoo Matiz', :description => 'pr. 2001, benzyna',
    :car_class => 'C'},
  {:name => 'Polonez Caro', :description => 'posiada instalację gazową',
   :car_class => 'B'},
  {:name => 'Daewoo Lanos', :description => 'pr. 2006, benzyna+LPG, pod.pow."\
   " dla kierowcy', :car_class => 'B'},
  {:name => 'Ford Mondeo', :description => 'produkcja 2010r., diesel',
   :car_class => 'A'},
  {:name => 'Jeep Grand Cherokee', :description => 'pr. 2004, diesel',
   :car_class => 'A'}
])

maluch = Car.first

maluch.terms.create!(:person => 'Monika Kowalska',
                        :date_of_rent => Date.current,
                        :date_of_return => Date.current.advance(days: 2))

maluch.terms.create!(:person => 'Tomasz Wicher',
                      :date_of_rent => Date.current.advance(days: 3),
                      :date_of_return => Date.current.advance(days: 6))

Car.last.terms.create!(:person => 'Grzegorz Mnich',
                         :date_of_rent => Date.current,
                         :date_of_return => Date.tomorrow)


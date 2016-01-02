# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Car.create!([
  {:nazwa => 'Fiat 126p', :opis => '15-letni maluch', :klasa => 'C'},
  {:nazwa => 'Daewoo Matiz', :opis => 'pr. 2001, benzyna', :klasa => 'C'},
  {:nazwa => 'Polonez Caro', :opis => 'posiada instalację gazową', :klasa => 'B'},
  {:nazwa => 'Daewoo Lanos', :opis => 'pr. 2006, benzyna+LPG, pod. pow. dla kierowcy',
                             :klasa => 'B'},
  {:nazwa => 'Ford Mondeo', :opis => 'produkcja 2010r., diesel', :klasa => 'A'},
  {:nazwa => 'Jeep Grand Cherokee', :opis => 'pr. 2004, diesel', :klasa => 'A'}

])

maluch = Car.first

maluch.termins.create!(:osoba => 'Monika Kowalska',
                        :data_wyp => Date.current,
                        :data_odd => Date.current.advance(days: 2))

maluch.termins.create!(:osoba => 'Tomasz Wicher',
                      :data_wyp => Date.current.advance(days: 3),
                      :data_odd => Date.current.advance(days: 6))

Car.last.termins.create!(:osoba => 'Grzegorz Mnich',
                         :data_wyp => Date.current,
                         :data_odd => Date.tomorrow)


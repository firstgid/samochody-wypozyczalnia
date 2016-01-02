require 'rails_helper'

RSpec.feature "Termins", type: :feature do
  before do
    @maluch = Car.create!(nazwa: "fiat 126p", opis: "stary grat", klasa: "C")
    @polonez = Car.create!(nazwa: 'Polonez Caro', opis: 'posiada instalację gazową', klasa: 'B')
    @termin = {:osoba => 'Monika Kowalska',
      :data_wyp => Date.current.advance(months: 1),
      :data_odd => Date.current.advance(months: 2)}

    @termin2 = {:osoba => 'Piotr Wiśnia',
      :data_wyp => Date.current,
      :data_odd => Date.current + 3}

    @termin3 = {:osoba => 'Tomasz Kowal',
      :data_wyp => @termin[:data_wyp],
      :data_odd => @termin[:data_odd]}
  end

  describe 'Creating Termin objects work with site form' do
    it 'creating 2 valid @maluch.termins' do
      visit cars_url

      click_link @maluch[:nazwa]
      click_link 'nowy termin'
      fill_in 'Osoba', :with => @termin[:osoba]
      fill_in 'Data wypożyczenia', :with => @termin[:data_wyp]
      fill_in 'Data oddania', :with => @termin[:data_odd]
      click_button 'utwórz'

      expect(current_url).to eq car_url(@maluch)
      expect(page.body).to have_content('pomyślnie utworzono nowy termin')

      click_link 'nowy termin'
      fill_in 'Osoba', :with => @termin2[:osoba]
      fill_in 'Data wypożyczenia', :with => @termin2[:data_wyp]
      fill_in 'Data oddania', :with => @termin2[:data_odd]
      click_button 'utwórz'

      expect(current_url).to eq car_url(@maluch)
      expect(page.body).to have_content('pomyślnie utworzono nowy termin')
    end

    it 'test errors' do
      visit car_url(@maluch)

      click_link 'nowy termin'
      click_button 'utwórz'

      expect(current_url).to eq "http://www.example.com/termins"

      blank = "can't be blank"
      #Capybara.exact = true
      expect(page.body).to have_content("Osoba #{blank}")
      expect(page.body).to have_content("Data wyp #{blank}")
      expect(page.body).to have_content("Data odd #{blank}")
      expect(page.body).to_not have_content("Osoba test #{blank}")
      expect(current_url).to eq "http://www.example.com/termins"

      fill_in 'Osoba', :with => @termin[:osoba]
      click_button 'utwórz'

      Capybara.exact = true
      expect(page.body).to have_content("Data wyp #{blank}")
      expect(page.body).to have_content("Data odd #{blank}")
      expect(page.body).to_not have_content("Osoba #{blank}")
    end
  end
end

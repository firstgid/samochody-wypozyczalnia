require 'rails_helper'

RSpec.feature "Termins", type: :feature do
  before do
    @maluch = Car.create!(name: "fiat 126p", description: "stary grat", car_class: "C")
    @polonez = Car.create!(name: 'Polonez Caro', description: 'posiada instalację gazową', car_class: 'B')
    @termin = {:person => 'Monika Kowalska',
      :date_of_rent => Date.current.advance(months: 1),
      :date_of_return => Date.current.advance(months: 2)}

    @termin2 = {:person => 'Piotr Wiśnia',
      :date_of_rent => Date.current,
      :date_of_return => Date.current + 3}

    @termin3 = {:person => 'Tomasz Kowal',
      :date_of_rent => @termin[:date_of_rent],
      :date_of_return => @termin[:date_of_return]}
  end

  describe 'Creating Termin objects work with site form' do
    it 'creating 2 valid @maluch.termins' do
      visit cars_url

      click_link @maluch[:name]
      click_link 'nowy termin'
      fill_in 'Osoba', :with => @termin[:person]
      fill_in 'Data wypożyczenia', :with => @termin[:date_of_rent]
      fill_in 'Data oddania', :with => @termin[:date_of_return]
      click_button 'utwórz'

      expect(current_url).to eq car_url(@maluch)
      expect(page.body).to have_content('pomyślnie utworzono nowy termin')

      click_link 'nowy termin'
      fill_in 'Osoba', :with => @termin2[:person]
      fill_in 'Data wypożyczenia', :with => @termin2[:date_of_rent]
      fill_in 'Data oddania', :with => @termin2[:date_of_return]
      click_button 'utwórz'

      expect(current_url).to eq car_url(@maluch)
      expect(page.body).to have_content('pomyślnie utworzono nowy termin')
    end

    it 'test errors' do
      visit car_url(@maluch)

      click_link 'nowy termin'
      click_button 'utwórz'

      expect(current_url).to eq "http://www.example.com/terms"

      blank = "can't be blank"
      not_date = 'is not a date'

      Capybara.exact = true
      expect(page.body).to have_content("Person #{blank}")
      expect(page.body).to have_content("Date of rent #{not_date}")
      expect(page.body).to have_content("Date of return #{not_date}")
      expect(page.body).to_not have_content("Person test #{blank}")
      expect(current_url).to eq "http://www.example.com/terms"

      fill_in 'Osoba', :with => @termin[:person]
      click_button 'utwórz'

#     Capybara.exact = true
      expect(page.body).to have_content("Date of rent #{not_date}")
      expect(page.body).to have_content("Date of return #{not_date}")
      expect(page.body).to_not have_content("Person #{blank}")
    end
  end

  describe "new_termin has" do
    it "working link 'wróć'" do
      visit car_url(@maluch)

      click_link 'nowy termin'
      expect(current_url).to eq(new_term_url + '?car_id=1')
      click_link 'wróć'
      expect(current_url).to eq(car_url(@maluch))
    end
  end
end

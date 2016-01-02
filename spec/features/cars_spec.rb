require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  before do
    @fpunto = Car.new(nazwa: 'fiat punto', opis: 'poduszka powietrzna dla kierowcy',
                     klasa: 'B')
  end

  describe "Car - new, create" do
    it "create Car with form - valid" do
      visit new_car_url

      fill_in 'car_nazwa', :with => @fpunto.nazwa
      fill_in 'car_opis', :with => @fpunto.opis
      fill_in 'car_klasa', :with => @fpunto.klasa
      click_button 'utwórz'

      expect(page.body).to have_content("dodanie nowego samochodu przebiegło pomyślnie")
      expect(page.body).to have_content(@fpunto.nazwa)
      expect(page.body).to have_content(@fpunto.opis)
    end

    it "create Car with form - invalid" do
      li_a = ["Nazwa is too short (minimum is 3 characters)", "Nazwa can't be blank",
          "Opis can't be blank", "Klasa can't be blank", "Klasa is not included in the list"]
      visit new_car_url

      fill_in 'car_nazwa', :with => ''
      fill_in 'car_opis', :with => ''
      fill_in 'car_klasa', :with => ''
      click_button 'utwórz'

      0.upto(4) do |i|
        expect(page.body).to have_css('li', li_a[i])
      end
    end
  end#describe

  describe "menu" do
    it "links work" do
      visit root_url

      click_link 'Nowy samochód'
      expect(current_url).to eq new_car_url
      click_link 'Lista samochodów'
      expect(current_url).to eq cars_url
    end
  end

  describe "Car - update, destroy" do
    it "=>update" do
      @fpunto.save!
      visit edit_car_url(1)

      fill_in 'car_opis', :with => "pp dla kierowcy i pasażera"
      click_button 'edytuj'

      expect(current_url).to eq(car_url(1))
      expect(page.body).to have_content("pp dla kierowcy i pasażera")
    end

    it "=> destroy" do
      @fpunto.save!
      visit car_url(1)

      click_link 'usuń'
      expect(current_url).to eq(cars_url)
      expect(page.body).to_not have_content(@fpunto.nazwa)
    end
  end
end

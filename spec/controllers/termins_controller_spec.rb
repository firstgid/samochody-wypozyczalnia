require 'rails_helper'

RSpec.describe TerminsController, type: :controller do

  before do
    @fpunto = Car.create!(nazwa: 'fiat punto', opis: 'poduszka powietrzna dla kierowcy',
                     klasa: 'B')
    @termin = @fpunto.termins.build(
      :osoba => 'Krzysztof Koza',
      :data_wyp => Date.current,
      :data_odd => Date.current + 1)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end

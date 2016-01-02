require 'rails_helper'

RSpec.describe CarsController, type: :controller do

  before do
    @fpunto = Car.new(nazwa: 'fiat punto', opis: 'poduszka powietrzna dla kierowcy',
                     klasa: 'B')
    @fpunto.save!
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, :id => 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, :id => 1
      expect(response).to have_http_status(:success)
    end
  end

end

class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find_by(:id => params[:id].to_i)
    @terms = Term.where(:car_id => @car[:id]).order :date_of_rent
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(get_params)
    if @car.valid?
      @car.save
      flash[:success] = "dodanie nowego samochodu przebiegło pomyślnie"
      redirect_to @car
    else
      render :new
    end
  end

  def edit
    @car = find_by_id
  end

  def update
    prms = get_params
    @car = find_by_id
    @car.update(prms)
    flash[:success] = 'objekt został pomyślnie edytowany'
    redirect_to @car
  end

  def destroy
    @car = Car.find_by(:id => params[:id])
    @car.destroy
    flash[:success] = 'objekt został pomyślnie usunięty'
    redirect_to cars_path
  end

  private
    def get_params
      params.require(:car).permit(:name, :description, :car_class)
    end

    def find_by_id
      @c = Car.find_by(:id => params[:id])
    end
end

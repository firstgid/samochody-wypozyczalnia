class TerminsController < ApplicationController

  def new
    @termin = Termin.new
    @id = params[:car_id]
#   raise params.inspect
  end

  def create
    values = get_params
    car = Car.find_by(:id => values[:car_id])
    @id = values[:car_id]
   #@termin = Termin.new get_params
    if car.nil?
      @termin = Termin.new
      flash.now[:warning] = 'nie znaleziono takiego samochodu'
      render :new
    else
      @termin = car.termins.build(get_params)
      if @termin.save
        flash[:success] = 'pomyślnie utworzono nowy termin'
        redirect_to car
        #flash[:success] = 'pomyślnie utworzono nowy termin'
      else
        #redirect_to new_termin_path
        #redirect_to :back
        render :new
      end
    end
  end

  def destroy
    ter = Termin.find_by(:id => params[:id])
    ter.destroy
    @terminy = Termin.all
    flash.now[:success] = 'pomyślnie usunięto termin'
    render :index
  end

  private
    def get_params
      params.require(:termin).permit(:osoba, :car_id, :data_wyp, :data_odd)
    end
end

class TermsController < ApplicationController
  def new
    @term = Term.new
    @id = params[:car_id]
  end

  def create
    values = get_params
    car = Car.find_by(:id => values[:car_id])
    @id = values[:car_id]
    if car.nil?
      @term = Termin.new
      flash.now[:warning] = 'nie znaleziono takiego samochodu'
      render :new
    else
      @term = car.terms.build(get_params)
      if @term.save
        flash[:success] = 'pomyślnie utworzono nowy termin'
        redirect_to car
      else
        render :new
      end
    end
  end

  def destroy
    ter = Termin.find_by(:id => params[:id])
    ter.destroy
    @terms = Termin.all
    flash.now[:success] = 'pomyślnie usunięto termin'
    render :index
  end

  private
    def get_params
      params.require(:term).permit(:person, :car_id, :date_of_return,
                                   :date_of_rent)
    end
end

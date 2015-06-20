class CitiesController < ApplicationController
  def index
    render json: City.all
  end

  def create
    city = City.new city_params
    render json: city.save ? city : format_errors(city)
  end

  def update
    city = City.find params[:id]
    render json: city.update_attributes(city_params) ? city : format_errors(city)
  end

  def destroy
    city = City.find params[:id]
    render json: city.destroy ? true : format_errors(city)
  end

  def destinations
    render json: City.destinations, root: :destinations
  end

  private
  def city_params
    params.require(:city).permit(:name, routes: [:to, :distance])
  end
end

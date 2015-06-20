class MapsController < ApplicationController
  def index
    render json: Map.all
  end

  def create
    map = Map.new map_params
    render json: map.save ? map : format_errors(map)
  end

  def update
    map = Map.find params[:id]
    render json: map.update_attributes(map_params) ? map : format_errors(map)
  end

  def destroy
    map = Map.find params[:id]
    render json: map.destroy ? true : format_errors(map)
  end

  private
  def map_params
    params.require(:map).permit(:name)
  end
end

class RoutesController < ApplicationController
  def shortest
    render json: Route.shortest_path(params[:from], params[:to], params[:autonomy], params[:fuel_price])
  end
end

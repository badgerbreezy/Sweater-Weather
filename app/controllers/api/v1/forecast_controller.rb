class Api::V1::ForecastController < ApplicationController
  def index
    new_forecast = ForecastFacade.get_forecast(location_params)
    render json: ForecastSerializer.new(new_forecast)
  end

  private

  def location_params
    params.permit(:location)
  end
end

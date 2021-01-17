class Api::V1::ForecastController < ApplicationController
  def index
    forecast_facade = ForecastFacade.get_forecast(location_params)
    new_forecast = Forecast.new(forecast_facade)
    render json: ForecastSerializer.new(new_forecast)
  end

  private

  def location_params
    params.permit(:location)
  end
end

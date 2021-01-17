class Api::V1::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(ForecastFacade.get_forecast(location_params))
  end

  private

  def location_params
    params.permit(:location)
  end
end

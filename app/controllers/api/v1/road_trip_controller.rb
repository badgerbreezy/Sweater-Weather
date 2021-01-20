class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: trip_params[:api_key])
    if user
      rt_facade = RoadTripFacade.create_road_trip(trip_params)
      render json: RoadTripSerializer.new(rt_facade)
    elsif trip_params[:api_key].empty?
      render json: payload[:api_key_missing], status: :unauthorized
      return
    else
      render json: payload[:incorrect_api_key], status: :unauthorized
      return
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def payload
    {
      incorrect_api_key: {
        error: 'Incorrect API Key',
        status: 401
      },
      api_key_missing: {
        error: 'API Key is missing',
        status: 401
      }
    }
  end
end

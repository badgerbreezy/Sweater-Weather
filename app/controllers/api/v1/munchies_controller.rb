class Api::V1::MunchiesController < ApplicationController
  def create
    user = User.find_by(api_key: munchies_params[:api_key])
    if user
      trip_data = MapquestService.get_directions_data(munchies_params[:origin], munchies_params[:destination])

      munchies_data = YelpService.get_restaurant_data(munchies_params[:restaurant], munchies_params[:destination])

      munchies = Munchies.new(munchies_data, trip_data)
      render json: MunchiesSerializer.new(munchies)

      # munchies_facade = MunchiesFacade.create_road_trip(trip_params)
    else
      render json: payload[:incorrect_api_key], status: :unauthorized
      return
    end
  end

  private

  def munchies_params
    params.permit(:origin, :destination, :restaurant, :api_key)
  end

  def payload
    {incorrect_api_key: {
      error: 'Incorrect API Key',
      status: 401
    }}
  end
end

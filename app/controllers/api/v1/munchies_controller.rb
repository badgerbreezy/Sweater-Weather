class Api::V1::MunchiesController < ApplicationController
  def create
    user = User.find_by(api_key: munchies_params[:api_key])
    if user
      trip = MapquestService.get_directions_data(munchies_params[:origin], munchies_params[:destination])
      munchies = yelp_service(munchies_params[:restaurant], munchies_params[:destination])
      Munchies.new(munchies, trip)

      # munchies_facade = MunchiesFacade.create_road_trip(trip_params)
      # render json: MunchiesSerializer.new(munchies_facade)
    else
      render json: payload[:incorrect_api_key], status: :unauthorized
      return
    end
  end

  private

  def munchies_params
    params.permit(:origin, :destination, :restaurant, :api_key)
  end

  def yelp_service(term, location)
    conn = Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
    response = conn.get("/v3/businesses/search") do |req|
      req.params[:term] = term
      req.params[:location] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def payload
    {incorrect_api_key: {
      error: 'Incorrect API Key',
      status: 401
    }}
  end
end

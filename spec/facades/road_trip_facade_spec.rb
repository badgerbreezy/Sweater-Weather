require 'rails_helper'

describe RoadTripFacade, type: :facade do
  describe 'class methods', :vcr do
    it '.create_road_trip' do
      params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
        }

      trip = RoadTripFacade.create_road_trip(params)

      expect(trip).to be_a(Trip)
      expect(trip.start_city).to be_a(String)
      expect(trip.start_city).to eq("Denver, CO")
      expect(trip.end_city).to be_a(String)
      expect(trip.end_city).to eq("Pueblo, CO")
      expect(trip.id).to eq(nil)
      expect(trip.travel_time).to be_a(String)
      expect(trip.weather_at_eta).to be_a(Hash)
      expect(trip.weather_at_eta.keys).to eq([:temperature, :conditions])
      expect(trip.weather_at_eta[:temperature]).to be_a(Float).or be_an(Integer)
      expect(trip.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end

require 'rails_helper'

describe RoadTripFacade, type: :facade do
  describe 'class methods', :vcr do
    before :each do
      @params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
        }
    end

    it '.create_road_trip' do
      trip = RoadTripFacade.create_road_trip(@params)

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

    it '.create_road_trip sad' do
      params = {
        "origin": "denver,CO",
        "destination": "new delhi, in",
        "api_key": "jgn983hy48thw9begh98h4539h4"
        }

      trip = RoadTripFacade.create_road_trip(params)

      expect(trip).to be_a(Trip)
      expect(trip.start_city).to be_a(String)
      expect(trip.start_city).to eq("Denver, CO")
      expect(trip.end_city).to be_a(String)
      expect(trip.end_city).to eq("New Delhi, IN")
      expect(trip.id).to eq(nil)
      expect(trip.travel_time).to be_a(String)
      expect(trip.travel_time).to eq("Impossible")
      expect(trip.weather_at_eta).to eq(nil)
    end

    it '.trip_data' do
      data = RoadTripFacade.trip_data(@params)
      
      expect(data).to be_a(Hash)
    end

    it '.trip_time' do
      data = RoadTripFacade.trip_time(@params)

      expect(data).to be_a(String)
    end

    it '.time_convert' do
      data = RoadTripFacade.time_convert(@params)

      expect(data).to be_an(Array)
      expect(data.length).to eq(2)
    end

    it '.weather_arrival' do
      method = RoadTripFacade.weather_arrival(@params)

      expect(method).to be_a(Hash)
      expect(method.keys.length).to eq(2)
      expect(method).to have_key(:temperature)
      expect(method).to have_key(:conditions)
      expect(method[:temperature]).to be_a(Numeric)
      expect(method[:conditions]).to be_a(String)
    end
  end
end

require 'rails_helper'

describe Trip, type: :poro do
  before :each do
    @trip_data = {
      :route=>{
        :formattedTime=>"03:21:41",
        :locations=>[
          {
            :street=>"",
            :adminArea5=>"Denver",
            :adminArea3=>"CO",
            :postalCode=>"",
            :latLng=> {
              "lng": -104.984853,
              "lat": 39.738453
            }
          },
          {
            :street=>"",
            :adminArea5=>"Aspen",
            :adminArea3=>"CO",
            :postalCode=>"",
            :latLng=> {
              "lng": -106.819201,
              "lat": 39.190665
            }
          }
        ]
      }
    }

    @trip = Trip.new(@trip_data)
  end

  it 'exists and has attributes' do
    expect(@trip).to be_a(Trip)
    expect(@trip.id).to eq(nil)
    expect(@trip.start_city).to eq('Denver, CO')
    expect(@trip.end_city).to eq('Aspen, CO')
    expect(@trip.travel_time).to eq('3 hours, 21 minutes')
    expect(@trip.weather_at_eta).to be_a(Hash)
    expect(@trip.weather_at_eta).to have_key(:temperature)
    expect(@trip.weather_at_eta).to have_key(:conditions)
    expect(@trip.weather_at_eta[:temperature]).to be_an(Integer).or be_a(Float)
    expect(@trip.weather_at_eta[:conditions]).to be_a(String)
  end

  it 'can format address' do
    expect(@trip.convert_address(@trip_data[:route][:locations][0])).to eq('Denver, CO')
  end

  it 'can convert time to array' do
    expect(@trip.time_convert(@trip_data[:route][:formattedTime])).to eq(["3", "21"])
  end

  it 'can format time' do
    expect(@trip.time_format(@trip_data[:route][:formattedTime])).to eq('3 hours, 21 minutes')
  end

  it 'can find weather at eta' do
    trip_data = {
      :route=>{
        :formattedTime=>"40:34:31",
        :locations=>[
          {
            :street=>"",
            :adminArea5=>"New York",
            :adminArea3=>"NY",
            :postalCode=>"",
            :latLng=> {
              "lng": -74.007228,
              "lat": 40.713054
            }
          },
          {
            :street=>"",
            :adminArea5=>"Los Angeles",
            :adminArea3=>"CA",
            :postalCode=>"",
            :latLng=> {
              "lng": -118.243344,
              "lat": 34.052238
            }
          }
        ]
      }
    }
    trip = Trip.new(trip_data)
    location = Hash[trip_data[:route][:locations][1][:latLng].sort]
    hourly_weather = WeatherService.get_weather_data(location)[:hourly]

    expect(trip.eta_weather(trip_data)[:conditions]).to eq(hourly_weather[40][:weather][0][:description])
    expect(trip.eta_weather(trip_data)[:temperature]).to eq(hourly_weather[40][:temp])
  end
end

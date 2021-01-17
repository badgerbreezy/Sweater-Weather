require 'rails_helper'

describe 'WeatherService' do
  it 'returns weather data from lat and lng', :vcr do
    latlng = {
      lat: 39.738453,
      lng: -104.984853
    }
    
    response = WeatherService.get_weather_data(latlng)
    expect(response).to be_a(Hash)

    expect(response[:current]).to be_a(Hash)
    expect(response[:current][:dt]).to be_an(Integer)
    expect(response[:current][:sunrise]).to be_an(Integer)
    expect(response[:current][:sunset]).to be_an(Integer)
    expect(response[:current][:temp]).to be_an(Integer).or be_a(Float)
    expect(response[:current][:feels_like]).to be_a(Float)
    expect(response[:current][:humidity]).to be_an(Integer)
    expect(response[:current][:uvi]).to be_an(Integer)
    expect(response[:current][:visibility]).to be_an(Integer)
    expect(response[:current][:weather][0][:description]).to be_a(String)
    expect(response[:current][:weather][0][:icon]).to be_a(String)

    expect(response[:daily]).to be_an(Array)
    expect(response[:daily].length).to eq(8)
    expect(response[:daily][0][:dt]).to be_an(Integer)
    expect(response[:daily][0][:sunrise]).to be_an(Integer)
    expect(response[:daily][0][:sunset]).to be_an(Integer)
    expect(response[:daily][0][:temp][:max]).to be_a(Float).or be_a(Integer)
    expect(response[:daily][0][:temp][:min]).to be_a(Float).or be_a(Integer)
    expect(response[:daily][0][:weather][0][:description]).to be_a(String)
    expect(response[:daily][0][:weather][0][:icon]).to be_a(String)

    expect(response[:hourly]).to be_an(Array)
    expect(response[:hourly].length).to eq(48)
    expect(response[:hourly][0][:dt]).to be_an(Integer)
    expect(response[:hourly][0][:temp]).to be_an(Integer).or be_a(Float)
    expect(response[:hourly][0][:wind_speed]).to be_an(Integer).or be_a(Float)
    expect(response[:hourly][0][:wind_deg]).to be_an(Integer).or be_a(Float)
    expect(response[:hourly][0][:weather][0][:description]).to be_a(String)
    expect(response[:hourly][0][:weather][0][:icon]).to be_a(String)
    # binding.pry
  end
end

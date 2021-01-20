require 'rails_helper'

describe 'As an authorized user' do
  before :each do
    @user = User.create(
      "email": "pitterpatter@gmail.com",
      "password": "password",
    )
    @headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  it 'I can make a road trip' do
    request = {
      "origin": "DeNveR, CO",
      "destination": "las vegas, nv",
      "api_key": @user.api_key
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(request)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq("road_trip")
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes][:start_city]).to be_a(String)
    expect(json[:data][:attributes][:start_city]).to eq("Denver, CO")
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes][:end_city]).to be_a(String)
    expect(json[:data][:attributes][:end_city]).to eq("Las Vegas, NV")
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(json[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
    expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float).or be_a(Float)
    expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'I receive a 401 if api key is invalid' do
    request = {
      "origin": "Denver, CO",
      "destination": "Las Vegas, NV",
      "api_key": "asdf234hygq3ergweah5y4"
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Incorrect API Key")
    expect(json[:status]).to eq(401)
  end

  it 'I receive a 401 if api key is blank' do
    request = {
      "origin": "Denver, CO",
      "destination": "Las Vegas, NV",
      "api_key": ""
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("API Key is missing")
    expect(json[:status]).to eq(401)
  end

  it 'I am notified if I make an impossible trip' do
    request = {
      "origin": "Denver, CO",
      "destination": "London, UK",
      "api_key": @user.api_key
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(request)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq("road_trip")
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes][:start_city]).to be_a(String)
    expect(json[:data][:attributes][:start_city]).to eq("Denver, CO")
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes][:end_city]).to be_a(String)
    expect(json[:data][:attributes][:end_city]).to eq("London, UK")
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)
    expect(json[:data][:attributes][:travel_time]).to eq('Impossible')
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to eq(nil)
  end
end

require 'rails_helper'

describe 'As an authorized user' do
  before :each do
    @user = User.create(
      "email": "pitterpatter@gmail.com",
      "password": "password",
    )
  end

  it 'I can make a road trip that will show open restaurants' do
    request = {
      "origin": "Denver, CO",
      "destination": "Aspen, CO",
      "restaurant": "Chinese",
      "api_key": @user.api_key
    }

    post '/api/v1/munchies', params: request

    expect(response).to be_successful
    # binding.pry
    expect(response.status).to eq(200)
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq("munchies")
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:destination_city)
    expect(json[:data][:attributes][:destination_city]).to be_a(String)
    expect(json[:data][:attributes][:destination_city]).to eq("Aspen, CO")
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:forecast)
    expect(json[:data][:attributes][:forecast]).to be_a(Hash)
    expect(json[:data][:attributes][:forecast].keys).to eq([:temperature, :summary])
    expect(json[:data][:attributes][:forecast][:temperature]).to be_a(Float).or be_a(Float)
    expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)

    expect(json[:data][:attributes]).to have_key(:restaurant)
    expect(json[:data][:attributes][:restaurant]).to be_a(Hash)
    expect(json[:data][:attributes][:restaurant].keys).to eq([:name, :address])
    expect(json[:data][:attributes][:restaurant][:name]).to be_a(String)
    expect(json[:data][:attributes][:restaurant][:address]).to be_a(String)
  end
end

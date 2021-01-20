require 'rails_helper'

describe 'As a user when I visit the welcome page' do
  it 'a request retrieves a JSON response of weather data' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('image')
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(nil)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to be_a(Hash)
    expect(json[:data][:attributes][:image]).to have_key(:location)
    expect(json[:data][:attributes][:image][:location]).to be_a(String)
    expect(json[:data][:attributes][:image][:location]).to eq('denver,co')
    expect(json[:data][:attributes][:image]).to have_key(:image_url)
    expect(json[:data][:attributes][:image][:image_url]).to be_a(String)
    expect(json[:data][:attributes][:image]).to have_key(:credit)
    expect(json[:data][:attributes][:image][:credit]).to be_a(Hash)
    expect(json[:data][:attributes][:image][:credit]).to have_key(:source)
    expect(json[:data][:attributes][:image][:credit][:source]).to be_a(String)
  end

  it 'an empty request returns an error message' do
    get '/api/v1/backgrounds?location='

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(response.message).to eq("Bad Request")
    expect(response.content_type).to eq("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to be_a(Hash)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Location cannot be empty")
    expect(json).to have_key(:status)
    expect(json[:status]).to eq("400")
  end
end

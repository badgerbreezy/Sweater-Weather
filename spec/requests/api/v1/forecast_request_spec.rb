require 'rails_helper'

describe 'As a user when I visit the welcome page' do
  it 'a request retrieves a JSON response of weather data', :vcr do
    get '/api/v1/forecast?location=denver,co'
    expect(response).to be_successful
    # expect(response.content_type).to include("application/json")
    binding.pry
  end
end

require 'rails_helper'

describe 'As a visitor' do
  it 'I can sign up as a user' do
    request = {
      "email": "pitterpatter@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', params: request
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to_not eq(nil)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('users')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:api_key)
    expect(json[:data][:attributes][:api_key]).to be_a(String)
    expect(json[:data][:attributes]).to_not include(:password)
    expect(json[:data][:attributes]).to_not include(:password_digest)
  end

  it 'I receive a 401 if registration is invalid' do
    request = {
      "email": "pitterpatter@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post '/api/v1/users', params: request
  end

  # passwords don’t match, email has already been taken, missing a field, etc.
end

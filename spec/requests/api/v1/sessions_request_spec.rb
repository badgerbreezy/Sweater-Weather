require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @user = User.create(
      "email": "pitterpatter@gmail.com",
      "password": "password"
    )
    @headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end

  it 'I can log in as a user' do
    request = {
      "email": "pitterpatter@gmail.com",
      "password": "password"
    }

    post '/api/v1/sessions', headers: @headers, params: JSON.generate(request)

    expect(response).to be_successful
    expect(response.status).to eq(200)
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

  it 'I receive a 401 if email does not exist' do
    request = {
      "email": "canadagooses@gmail.com",
      "password": "password",
    }

    post '/api/v1/sessions', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Email does not exist")
    expect(json[:status]).to eq(401)
  end

  it 'I receive a 401 if password field is incorrect or missing' do
    request1 = {
      "email": "pitterpatter@gmail.com",
      "password": "12341235"
    }
    request2 = {
      "email": "pitterpatter@gmail.com",
      "password": ""
    }

    post '/api/v1/sessions', headers: @headers, params: JSON.generate(request1)
    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password is incorrect")
    expect(json[:status]).to eq(401)

    post '/api/v1/sessions', headers: @headers, params: JSON.generate(request2)
    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password is incorrect")
    expect(json[:status]).to eq(401)
  end

  it 'I receive a 401 if email field is missing' do
    request = {
      "email": "",
      "password": "password"
    }
    post '/api/v1/sessions', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Email does not exist")
    expect(json[:status]).to eq(401)
  end
end

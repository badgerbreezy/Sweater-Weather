require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @user = User.create(
      "email": "canadagooses@gmail.com",
      "password": "goosesandmeese"
    )
    @headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
  end
  
  it 'I can sign up as a user' do
    request = {
      "email": "pitterpatter@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', headers: @headers, params: JSON.generate(request)

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

  it 'I receive a 401 if email has been taken' do
    request = {
      "email": "canadagooses@gmail.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Email has already been taken")
    expect(json[:status]).to eq(401)
  end

  it 'I receive a 401 if password field is missing' do
    request = {
      "email": "canadagooses@gmail.com",
      "password": "",
      "password_confirmation": "password"
    }

    post '/api/v1/users', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password can't be blank")
    expect(json[:status]).to eq(401)
  end

  it 'I receive a 401 if email field is missing' do
    request = {
      "email": "",
      "password": "password",
      "password_confirmation": "password"
    }

    post '/api/v1/users', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Email can't be blank")
    expect(json[:status]).to eq(401)
  end

  it 'I receive a 401 if passwords dont match' do
    request = {
      "email": "meese@gmail.com",
      "password": "password",
      "password_confirmation": "birdword"
    }

    post '/api/v1/users', headers: @headers, params: JSON.generate(request)

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
    expect(response.content_type).to include("application/json")
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to_not have_key(:data)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Password confirmation doesn't match Password")
    expect(json[:status]).to eq(401)
  end
end

require 'rails_helper'

describe Trip, type: :poro do
  before :each do
    @origin = 'denver,co'
    @destination = 'aspen, co'
    @time = "03:21:41"
    @weather = {:temperature=>27.63, :conditions=>"clear sky"}
    @trip = Trip.new(@origin, @destination, @time, @weather)
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

  it 'can convert address' do
    expect(@trip.convert_address(@origin)).to eq('Denver, CO')
    expect(@trip.convert_address(@destination)).to eq('Aspen, CO')
  end

  it 'can convert time to array' do
    expect(@trip.time_convert(@time)).to eq(["3", "21"])
  end

  it 'can format time' do
    time = "Impossible"
    expect(@trip.time_format(@time)).to eq('3 hours, 21 minutes')
    expect(@trip.time_format(time)).to eq('Impossible')
  end

  it 'does not allow cross continental trips' do
    origin = 'denver,co'
    destination = 'london, uk'
    time = "Impossible"
    weather = nil
    trip = Trip.new(origin, destination, time, weather)

    expect(trip).to be_a(Trip)
    expect(trip.id).to eq(nil)
    expect(trip.start_city).to eq('Denver, CO')
    expect(trip.end_city).to eq('London, UK')
    expect(trip.travel_time).to eq('Impossible')
    expect(trip.weather_at_eta).to eq(nil)
  end
end

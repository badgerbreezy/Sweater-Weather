require 'rails_helper'

describe WeatherHourly, type: :poro do
  before :each do
    data = {:dt=>1610856000,
            :temp=>272.06,
            :wind_speed=>1.66,
            :wind_deg=>150,
            :weather=>[{:description=>"overcast clouds", :icon=>"04n"}]
          }

    @weather_hourly = WeatherHourly.new(data)
  end

  it 'exists and has attributes' do
    expect(@weather_hourly).to be_a(WeatherHourly)
    expect(@weather_hourly.time).to eq('21:00:00')
    expect(@weather_hourly.temperature).to eq(272.06)
    expect(@weather_hourly.wind_speed).to eq("1.66 mph")
    expect(@weather_hourly.wind_direction).to eq('from SSE')
    expect(@weather_hourly.conditions).to eq("overcast clouds")
    expect(@weather_hourly.icon).to eq("04n")
  end

  describe 'instance methods' do
    it 'fahrenheit' do
      temp = 271.63
      expect(@weather_hourly.fahrenheit(temp).round(2)).to eq(30.48)
    end
  end
end

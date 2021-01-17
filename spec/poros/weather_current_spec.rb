require 'rails_helper'

describe WeatherCurrent, type: :poro do
  before :each do
    data = {
      :dt=>1610856435,
      :sunrise=>1610806713,
      :sunset=>1610841641,
      :temp=>272.06,
      :feels_like=>268.05,
      :humidity=>62,
      :uvi=>0,
      :visibility=>10000,
      :weather=>[{:description=>"overcast clouds", :icon=>"04n"}]
    }
    @weather_current = WeatherCurrent.new(data)
  end

  it 'exists and has attributes' do
    expect(@weather_current).to be_a(WeatherCurrent)
    expect(@weather_current.datetime).to eq('2021-01-17 04:07:15 +0000')
    expect(@weather_current.sunrise).to eq('2021-01-16 02:18:33 +0000')
    expect(@weather_current.sunset).to eq('2021-01-17 12:00:41 +0000')
    expect(@weather_current.temperature).to eq(272.06)
    expect(@weather_current.feels_like).to eq(268.05)
    expect(@weather_current.humidity).to eq(62)
    expect(@weather_current.uvi).to eq(0)
    expect(@weather_current.visibility).to eq(10000)
    expect(@weather_current.conditions).to eq("overcast clouds")
    expect(@weather_current.icon).to eq("04n")
  end

  describe 'instance methods' do
    it 'fahrenheit' do
      temp = 271.63
      expect(@weather_current.fahrenheit(temp).round(2)).to eq(30.48)
    end
  end
end

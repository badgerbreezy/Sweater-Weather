require 'rails_helper'

describe WeatherDaily, type: :poro do
  before :each do
    data = {:dt=>1610823600,
            :sunrise=>1610806713,
            :sunset=>1610841641,
            :temp=>{:min=>272.06, :max=>279.77},
            :weather=>[{:description=>"clear sky", :icon=>"01d"}]
          }

    @weather_daily = WeatherDaily.new(data)
  end

  it 'exists and has attributes' do
    expect(@weather_daily).to be_a(WeatherDaily)
    expect(@weather_daily.date).to eq('2021-01-16')
    expect(@weather_daily.sunrise).to eq('2021-01-16 02:18:33 +0000')
    expect(@weather_daily.sunset).to eq('2021-01-17 12:00:41 +0000')
    expect(@weather_daily.max_temp).to eq(38.62)
    expect(@weather_daily.min_temp).to eq(30.91)
    expect(@weather_daily.conditions).to eq("clear sky")
    expect(@weather_daily.icon).to eq("01d")
  end

  describe 'instance methods' do
    it 'fahrenheit' do
      temp = 271.63
      expect(@weather_daily.fahrenheit(temp).round(2)).to eq(30.48)
    end
  end
end

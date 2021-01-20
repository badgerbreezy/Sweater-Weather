require 'rails_helper'

describe Forecast, type: :poro do
  it 'exists and has attributes' do
    current_data = {
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
    daily_data = {:dt=>1610823600,
            :sunrise=>1610806713,
            :sunset=>1610841641,
            :temp=>{:min=>272.06, :max=>279.77},
            :weather=>[{:description=>"clear sky", :icon=>"01d"}]
          }
    hourly_data = {:dt=>1610856000,
            :temp=>272.06,
            :wind_speed=>1.66,
            :wind_deg=>150,
            :weather=>[{:description=>"overcast clouds", :icon=>"04n"}]
          }

    current = WeatherCurrent.new(current_data)
    daily = WeatherDaily.new(daily_data)
    hourly = WeatherHourly.new(hourly_data)
    forecast = {"current_weather": current, "daily_weather": daily, "hourly_weather": hourly}

    forecast_object = Forecast.new(forecast)

    expect(forecast_object).to be_a(Forecast)
    expect(forecast_object.current_weather).to be_a(WeatherCurrent)
    expect(forecast_object.daily_weather).to be_a(WeatherDaily)
    expect(forecast_object.hourly_weather).to be_a(WeatherHourly)
  end
end

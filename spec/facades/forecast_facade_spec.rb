require 'rails_helper'

describe ForecastFacade, type: :facade do
  describe 'class methods', :vcr do
    before :each do
      @location = 'denver,co'
      @geocodes = ForecastFacade.geocodes(@location)
      @forecast_data = ForecastFacade.forecast_data(@location)
    end

    it '.geocodes' do
      geocodes = ForecastFacade.geocodes(@location)
      expect(geocodes).to be_a(Hash)
      expect(geocodes[:lat]).to eq(39.738453)
      expect(geocodes[:lng]).to eq(-104.984853)
    end

    it '.forecast_data' do
      forecast_data = ForecastFacade.forecast_data(@location)
      expect(forecast_data).to be_a(Hash)
    end

    it '.forecast_current' do
      forecast_current = ForecastFacade.forecast_current(@location)
      expect(forecast_current).to be_a(WeatherCurrent)
    end

    it '.forecast_daily' do
      forecast_daily = ForecastFacade.forecast_daily(@location)
      expect(forecast_daily).to be_an(Array)
      expect(forecast_daily.length).to eq(5)
      forecast_daily.each do |day_weather|
        expect(day_weather).to be_a(WeatherDaily)
      end
    end

    it '.forecast_hourly' do
      forecast_hourly = ForecastFacade.forecast_hourly(@location)
      expect(forecast_hourly).to be_an(Array)
      expect(forecast_hourly.length).to eq(8)
      forecast_hourly.each do |hour_weather|
        expect(hour_weather).to be_a(WeatherHourly)
      end
    end

    it '.get_forecast' do
      forecast = ForecastFacade.get_forecast(@location)
      expect(forecast).to be_a(Hash)
      expect(forecast.keys.length).to eq(3)
      expect(forecast.keys).to eq([:current_weather, :daily_weather, :hourly_weather])
    end
  end
end

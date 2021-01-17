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
    end

    it '.forecast_data' do
      forecast_data = ForecastFacade.forecast_data(@location)
      expect(forecast_data).to be_a(Hash)
    end

    xit '.forecast_current' do
      forecast_current = ForecastFacade.forecast_current(@location)
      expect(forecast_current).to be_a(WeatherCurrent)
    end

    xit '.forecast_daily' do
      forecast_daily = ForecastFacade.forecast_daily(@location)
      expect(forecast_daily).to be_an(Array)
      expect(forecast_daily.length).to eq(8)
    end

    xit '.forecast_hourly' do
      forecast_hourly = ForecastFacade.forecast_hourly(@location)
      expect(forecast_hourly).to be_an(Array)
      expect(forecast_hourly.length).to eq(48)
    end

    xit '.get_forecast' do
      forecast = ForecastFacade.get_forecast(@location)
    end
  end
end

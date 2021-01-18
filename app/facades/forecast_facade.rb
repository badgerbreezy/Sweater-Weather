class ForecastFacade
  def self.get_forecast(location)
    results = forecast_data(location)
    join_forecast(location)
  end

  def self.join_forecast(location)
    forecast = {"current_weather": forecast_current(location), "daily_weather": forecast_daily(location), "hourly_weather": forecast_hourly(location)}
  end

  def self.forecast_data(location)
    coordinates = geocodes(location)
    forecast = WeatherService.get_weather_data(coordinates)
  end

  def self.forecast_current(location)
    WeatherCurrent.new(forecast_data(location)[:current])
  end

  def self.forecast_daily(location)
    forecast_data(location)[:daily][0..4].map do |day|
      WeatherDaily.new(day)
    end
  end

  def self.forecast_hourly(location)
    forecast_data(location)[:hourly][0..7].map do |day|
      WeatherHourly.new(day)
    end
  end

  def self.geocodes(location)
    GeocodeFacade.get_geolocation(location)
  end
end

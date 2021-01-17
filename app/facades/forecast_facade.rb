class ForecastFacade
  def self.get_forecast(location)
    results = WeatherService.get_weather_data(geocodes(location))
    join_forecast(results)
    # binding.pry
  end

  def self.join_forecast(results)
    # binding.pry
    forecast = {"current_weather": forecast_current(results), "daily_weather": forecast_daily(results), "hourly_weather": forecast_hourly(location)}
  end


  def self.forecast_data(location)
    coordinates = geocodes(location)
    forecast = WeatherService.get_weather_data(coordinates)
    binding.pry
  end

  def self.forecast_current(results)
    binding.pry
    current = WeatherCurrent.new(results[:current])
  end

  def self.forecast_daily(results)
    results[:daily].map do |day|
      WeatherDaily.new(day)
    end
  end

  def self.forecast_hourly(results)
    results[:hourly].map do |day|
      WeatherHourly.new(day)
    end
  end

  def self.geocodes(location)
    GeocodeFacade.get_geolocation(location)
    # binding.pry
  end
end

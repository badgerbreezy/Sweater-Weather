class RoadTripFacade
  def self.create_road_trip(trip_params)
    origin = trip_params[:origin]
    destination = trip_params[:destination]
    travel_time = trip_time(trip_params)
    if travel_time == nil
      Trip.new(origin, destination, "Impossible", nil)
    else
      weather_eta = weather_arrival(trip_params)
      Trip.new(origin, destination, travel_time, weather_eta)
    end
  end

  def self.trip_data(trip_params)
    data = MapquestService.get_directions_data(trip_params[:origin], trip_params[:destination])
  end

  def self.trip_time(trip_params)
    trip_data(trip_params)[:route][:formattedTime]
  end

  def self.weather_arrival(trip_params)
    location = Hash[trip_data(trip_params)[:route][:locations][1][:latLng].sort]
    hourly_weather = WeatherService.get_weather_data(location)[:hourly]
    trip_time = time_convert(trip_params)[0].to_i
    weather_data = {
      temperature: hourly_weather[trip_time][:temp],
      conditions: hourly_weather[trip_time][:weather][0][:description]
    }
  end

  def self.time_convert(trip_params)
    split_arr = trip_time(trip_params).split(":", 3)
    no_zero = split_arr.map do |int|
      int.to_i.to_s
    end.tap(&:pop)
  end
end

class Trip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(trip_data)
    @id = nil
    @start_city = convert_address(trip_data[:route][:locations][0])
    @end_city = convert_address(trip_data[:route][:locations][1])
    @travel_time = time_format(trip_data[:route][:formattedTime])
    @weather_at_eta = eta_weather(trip_data)
  end

  def convert_address(city)
    "#{city[:adminArea5].capitalize}, #{city[:adminArea3].upcase}"
  end

  def time_convert(time)
    split_arr = time.split(":", 3)
    no_zero = split_arr.map do |int|
      int.to_i.to_s
    end.tap(&:pop)
  end

  def time_format(time)
    format = time_convert(time)
    "#{format.first} hours, #{format.last} minutes"
  end

  def eta_weather(trip_data)
    location = Hash[trip_data[:route][:locations][1][:latLng].sort]
    hourly_weather = WeatherService.get_weather_data(location)[:hourly]
    trip_time = time_convert(trip_data[:route][:formattedTime])[0].to_i
    weather_data = {
      temperature: hourly_weather[trip_time][:temp],
      conditions: hourly_weather[trip_time][:weather][0][:description]
    }
  end
end

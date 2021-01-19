class Munchies
  attr_reader :id,
              :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(food, location)
    @id = nil
    @destination_city = convert_address(location[:route][:locations][1])
    @travel_time = time_format(location[:route][:formattedTime])
    @forecast = eta_weather(location)
    @restaurant = restaurants(food)
  end

  def convert_address(location)
    "#{location[:adminArea5].capitalize}, #{location[:adminArea3].upcase}"
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
      summary: hourly_weather[trip_time][:weather][0][:description]
    }
  end

  def restaurants(food)
    open = []
    food[:businesses].map do |business|
      if business[:is_closed] == false
        open << business
      end
    end
    restaurant_hash = Hash.new
    open.each do |business|
      restaurant_hash[:name] = business[:name]
      restaurant_hash[:address] = business[:location][:display_address]
    end
    restaurant = {
      name: restaurant_hash[:name],
      address: "#{restaurant_hash[:address][0]}, #{restaurant_hash[:address][1]}"
    }
  end
end

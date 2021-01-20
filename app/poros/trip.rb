class Trip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, time, weather)
    @id = nil
    @start_city = convert_address(origin)
    @end_city = convert_address(destination)
    @travel_time = time_format(time)
    @weather_at_eta = weather
  end

  def convert_address(address)
    ad_arr = address.gsub(',', ', ')
    city = ad_arr.split[0..-2].map { |c| c.capitalize }.join(" ")
    state = ad_arr.split.last.upcase
    (city + state).gsub(',', ', ')
  end

  def time_convert(time)
    split_arr = time.split(":", 3)
    no_zero = split_arr.map do |int|
      int.to_i.to_s
    end.tap(&:pop)
  end

  def time_format(time)
    return time if time == "Impossible"
    format = time_convert(time)
    "#{format.first} hours, #{format.last} minutes"
  end
end

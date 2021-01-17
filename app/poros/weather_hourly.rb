class WeatherHourly
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(data)
    @time = convert_utc_time(data[:dt])
    @temperature = fahrenheit(data[:temp]).round(2)
    @wind_speed = data[:wind_speed]
    @wind_direction = compass(data[:wind_deg])
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end

  def compass(deg)
    conversion = ((deg/22.5) + 0.5).to_i
    direction = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    direction[conversion]
  end

  def convert_utc_time(utc)
    Time.at(utc).strftime('%T')
  end
end

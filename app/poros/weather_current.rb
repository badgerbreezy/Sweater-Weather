class WeatherCurrent
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = convert_utc(data[:dt])
    @sunrise = convert_utc(data[:sunrise])
    @sunset = convert_utc(data[:sunset])
    @temperature = fahrenheit(data[:temp]).round(2)
    @feels_like = fahrenheit(data[:feels_like]).round(2)
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end

  def convert_utc(utc)
    DateTime.strptime(utc.to_s,'%s').strftime('%Y-%m-%d %I:%M:%S %z')
  end
end

class WeatherDaily
  attr_reader :date,
              :sunrise,
              :sunset,
              :min_temp,
              :max_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = convert_utc_date(data[:dt])
    @sunrise = convert_utc(data[:sunrise])
    @sunset = convert_utc(data[:sunset])
    @min_temp = data[:temp][:min].round(2)
    @max_temp = data[:temp][:max].round(2)
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end

  def convert_utc_date(utc)
    DateTime.strptime(utc.to_s, '%s').strftime('%Y-%m-%d')
  end

  def convert_utc(utc)
    DateTime.strptime(utc.to_s,'%s').strftime('%Y-%m-%d %I:%M:%S %z')
  end
end

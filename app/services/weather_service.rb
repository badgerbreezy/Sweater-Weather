class WeatherService
  def self.get_weather_data(location)
    response = conn.get("data/2.5/onecall") do |req|
      req.params[:lat] = location[:lat]
      req.params[:lon] = location[:lng]
      req.params[:units] = 'imperial'
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org/') do |req|
     req.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end
  end
end

class MapquestService
  def self.get_location_data(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params[:location] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_directions_data(from, to)
    response = conn.get("/directions/v2/route") do |req|
      req.params[:from] = from
      req.params[:to] = to
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
    end
  end
end

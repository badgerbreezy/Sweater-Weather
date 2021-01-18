class GeocodeService
  def self.get_location_data(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params[:key] = ENV['MAPQUEST_API_KEY']
      req.params[:location] = location
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end

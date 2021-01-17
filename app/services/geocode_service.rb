class GeocodeService
  def get_location_data(location)
    response = conn.get("/geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{location}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end

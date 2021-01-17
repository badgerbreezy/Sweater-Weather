class GeocodeFacade
  def self.get_geolocation(location)
    location_data = GeocodeService.get_location_data(location)[:results][0][:locations][0][:latLng]
    # puts 'Location Confirmed'
    # location_data.map do |coord, geocode|
    #   geocodes = [geocode]
    # end.flatten
  end
end

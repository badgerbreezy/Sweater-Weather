class GeocodeFacade
  def self.get_geolocation(location)
    location_data = GeocodeService.get_location_data(location)[:results][0][:locations][0][:latLng]
  end
end

require 'rails_helper'

describe GeocodeFacade, type: :facade do
  describe 'class methods', :vcr do
    it '.get_geolocation' do
      params = 'Denver'
      geolocation = GeocodeFacade.get_geolocation(params)
      expect(geolocation).to be_a(Hash)
      expect(geolocation).to have_key(:lat)
      expect(geolocation).to have_key(:lng)
      expect(geolocation[:lat]).to eq(39.738453)
      expect(geolocation[:lng]).to eq(-104.984853)
    end
  end
end

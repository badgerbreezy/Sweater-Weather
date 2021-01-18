require 'rails_helper'

describe GeocodeService do
  it 'returns data from a specific location', :vcr do
    response = GeocodeService.get_location_data('denver,co')

    expect(response).to be_a(Hash)
    expect(response[:results]).to be_an(Array)
    expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(39.738453)

    expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.984853)
  end
end

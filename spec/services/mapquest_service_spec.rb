require 'rails_helper'

describe MapquestService do
  it 'returns data from a specific location', :vcr do
    response = MapquestService.get_location_data('denver,co')

    expect(response).to be_a(Hash)
    expect(response[:results]).to be_an(Array)
    expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(39.738453)

    expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.984853)
  end

  it 'returns data for a route between a start and end location', :vcr do
    response = MapquestService.get_directions_data('denver,co', 'aspen,co')

    expect(response).to be_a(Hash)
    expect(response[:route]).to be_a(Hash)
    expect(response[:route][:formattedTime]).to be_a(String)
    expect(response[:route][:locations]).to be_an(Array)
    expect(response[:route][:locations].length).to eq(2)
    expect(response[:route][:locations][0]).to be_a(Hash)
    expect(response[:route][:locations][0]).to have_key(:street)
    expect(response[:route][:locations][0][:street]).to eq('')
    expect(response[:route][:locations][0]).to have_key(:adminArea5)
    expect(response[:route][:locations][0][:adminArea5]).to eq('Denver')
    expect(response[:route][:locations][0]).to have_key(:adminArea3)
    expect(response[:route][:locations][0][:adminArea3]).to eq('CO')
    expect(response[:route][:locations][0]).to have_key(:postalCode)
    expect(response[:route][:locations][0][:postalCode]).to eq('')
    expect(response[:route][:locations][0]).to have_key(:latLng)
    expect(response[:route][:locations][0][:latLng]).to be_a(Hash)
    expect(response[:route][:locations][0][:latLng][:lng]).to eq(-104.984853)
    expect(response[:route][:locations][0][:latLng][:lat]).to eq(39.738453)
    expect(response[:route][:locations][1]).to be_a(Hash)
    expect(response[:route][:locations][1]).to have_key(:street)
    expect(response[:route][:locations][1][:street]).to eq('')
    expect(response[:route][:locations][1]).to have_key(:adminArea5)
    expect(response[:route][:locations][1][:adminArea5]).to eq('Aspen')
    expect(response[:route][:locations][1]).to have_key(:adminArea3)
    expect(response[:route][:locations][1][:adminArea3]).to eq('CO')
    expect(response[:route][:locations][1]).to have_key(:postalCode)
    expect(response[:route][:locations][1][:postalCode]).to eq('')
    expect(response[:route][:locations][1]).to have_key(:latLng)
    expect(response[:route][:locations][1][:latLng]).to be_a(Hash)
    expect(response[:route][:locations][1][:latLng][:lng]).to eq(-106.819201)
    expect(response[:route][:locations][1][:latLng][:lat]).to eq(39.190665)
  end

  it 'returns data for an impossible route', :vcr do
    response = MapquestService.get_directions_data('denver,co', 'london,uk')
    expect(response).to be_a(Hash)
    expect(response[:route]).to be_a(Hash)
    expect(response[:route]).to_not have_key(:formattedTime)
    expect(response[:route]).to_not have_key(:locations)
    expect(response[:info]).to be_a(Hash)
    expect(response[:info][:statuscode]).to eq(402)
    expect(response[:info][:messages]).to eq(["We are unable to route with the given locations."])
  end
end

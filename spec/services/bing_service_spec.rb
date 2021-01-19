require 'rails_helper'

describe BingService do
  it 'returns image data by location param', :vcr do
    response = BingService.get_image_data('denver,co')
    expect(response).to be_a(Hash)
    expect(response[:value]).to be_an(Array)
    expect(response[:value][0]).to be_a(Hash)
    expect(response[:value][0][:contentUrl]).to be_a(String)
    expect(response[:value][0][:hostPageDomainFriendlyName]).to be_a(String)
  end
end

require 'rails_helper'

describe BingService do
  it 'returns image data by location param', :vcr do
    response = BingService.get_image_data('denver,co')
    expect(response).to be_a(Hash)
    expect(response[:value]).to be_an(Array)
    expect(response[:value][0]).to be_a(Hash)
    expect(response[:value][0][:contentUrl]).to be_a(String)
    expect(response[:value][0][:contentUrl]).to eq("https://local-store-res.cloudinary.com/image/upload/w_1440,h_550,c_fill,q_80,f_auto/Denver_CO-07b-hero-1440x550-4_fbkh8v")
    expect(response[:value][0][:hostPageDomainFriendlyName]).to be_a(String)
    expect(response[:value][0][:hostPageDomainFriendlyName]).to eq("Realtor.com")
  end
end

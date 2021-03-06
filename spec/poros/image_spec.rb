require 'rails_helper'

describe Image, type: :poro do
  before :each do
    @location = 'denver,co'
    @data = {
      :contentUrl=>"https://local-store-res.cloudinary.com/image/upload/w_1440,h_550,c_fill,q_80,f_auto/Denver_CO-07b-hero-1440x550-4_fbkh8v",
      :hostPageDomainFriendlyName=>"Realtor.com"
    }
    @image = Image.new(@location, @data)
  end

  it 'exists and has attributes' do
    expect(@image).to be_an(Image)
    expect(@image.image).to be_a(Hash)
    expect(@image.image[:location]).to be_a(String)
    expect(@image.image[:location]).to eq('denver,co')
    expect(@image.image[:image_url]).to be_a(String)
    expect(@image.image[:image_url]).to eq("https://local-store-res.cloudinary.com/image/upload/w_1440,h_550,c_fill,q_80,f_auto/Denver_CO-07b-hero-1440x550-4_fbkh8v")
    expect(@image.image[:credit]).to be_a(Hash)
    expect(@image.image[:credit]).to have_key(:source)
    expect(@image.image[:credit][:source]).to eq("Realtor.com")
  end
end

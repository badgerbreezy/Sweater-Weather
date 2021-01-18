require 'rails_helper'

describe BackgroundImageFacade, type: :facade do
  describe 'class methods', :vcr do
    it '.get_background_image' do
      params = 'denver,co'
      # image_data = BackgroundImageFacade.image_data(params)
      image = BackgroundImageFacade.get_background_image(params)
      expect(image).to be_an(Image)
      expect(image.image).to be_a(Hash)
      expect(image.image[:credit].keys).to eq([:source])
      expect(image.image[:credit]).to be_a(Hash)
      expect(image.image[:credit][:source]).to be_a(String)
      expect(image.image[:credit][:source]).to eq("Realtor.com")
      expect(image.image[:image_url]).to be_a(String)
      expect(image.image[:location]).to be_a(String)
      expect(image.image[:location]).to eq("denver,co")
      expect(image.image[:image_url]).to eq("https://local-store-res.cloudinary.com/image/upload/w_1440,h_550,c_fill,q_80,f_auto/Denver_CO-07b-hero-1440x550-4_fbkh8v")
    end
  end
end

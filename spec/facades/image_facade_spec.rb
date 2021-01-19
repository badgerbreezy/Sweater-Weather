require 'rails_helper'

describe BackgroundImageFacade, type: :facade do
  describe 'class methods', :vcr do
    it '.get_background_image' do
      params = 'denver,co'

      image = BackgroundImageFacade.get_background_image(params)

      expect(image).to be_an(Image)
      expect(image.image).to be_a(Hash)
      expect(image.image[:credit].keys).to eq([:source])
      expect(image.image[:credit]).to be_a(Hash)
      expect(image.image[:credit][:source]).to be_a(String)
      expect(image.image[:image_url]).to be_a(String)
      expect(image.image[:location]).to be_a(String)
      expect(image.image[:location]).to eq("denver,co")
      expect(image.image[:image_url]).to be_a(String)
    end
  end
end

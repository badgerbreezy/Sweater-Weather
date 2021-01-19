require 'rails_helper'

describe MunchiesFacade, type: :facade do
  describe 'class methods' do
    it '.create_trip_with_food' do
      params = {
        "start": "Denver,CO",
        "end_location": "Pueblo,CO",
        "food": "Mexican"
        }

      munchies = MunchiesFacade.create_trip_with_food(params)
      expect(munchies).to be_a(Munchies)
      expect(munchies.destination_city).to be_a(String)
      expect(munchies.destination_city).to eq("Pueblo, CO")
      expect(munchies.id).to eq(nil)
      expect(munchies.travel_time).to be_a(String)
      expect(munchies.forecast).to be_a(Hash)
      expect(munchies.forecast.keys).to eq([:temperature, :summary])
      expect(munchies.forecast[:temperature]).to be_a(Numeric)
      expect(munchies.forecast[:summary]).to be_a(String)
    end
  end
end

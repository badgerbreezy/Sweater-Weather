require 'rails_helper'

describe YelpService do
  it 'returns restaurant data by search params' do
    response = YelpService.get_restaurant_data('sushi', 'denver,co')
    expect(response).to be_a(Hash)
    expect(response[:businesses]).to be_an(Array)
    expect(response[:businesses][0]).to be_a(Hash)
    expect(response[:businesses][0]).to have_key(:name)
    expect(response[:businesses][0][:name]).to be_a(String)
    expect(response[:businesses][0]).to have_key(:is_closed)
    expect(response[:businesses][0][:is_closed]).to eq(true).or eq(false)
    expect(response[:businesses][0]).to have_key(:location)
    expect(response[:businesses][0][:location]).to be_a(Hash)
    expect(response[:businesses][0][:location][:display_address]).to be_an(Array)
  end
end

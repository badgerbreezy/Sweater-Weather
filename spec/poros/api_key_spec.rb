require 'rails_helper'

describe 'API key creation' do
  it 'can be created' do
    key = ApiKey.generator
    expect(key).to be_kind_of(String)
  end
end

require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'callbacks' do
    it 'will store the assigned api key when created' do
      user_params = {
        "email": "pitterpatter@gmail.com",
        "password": "password",
        "password_confirmation": "password"
      }
      user = User.create(user_params)
      expect(user.api_key).to_not be_nil
    end
  end
end

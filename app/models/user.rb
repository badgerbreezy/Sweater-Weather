class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: true
  validates_presence_of :email, :api_key
  validates :password, confirmation: { case_sensitive: true }

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end

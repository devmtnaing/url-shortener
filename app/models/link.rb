class Link < ApplicationRecord
  validates :original_url, presence: true
  validates :shortened_url, presence: true
  validates :shortened_url, uniqueness: true

  def generate_shortened_url
    SecureRandom.base64(6)
  end
end

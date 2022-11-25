class Link < ApplicationRecord
  validates :original_url, presence: true
  validates :shortened_url, uniqueness: true

  before_create :generate_shortened_url

  private

  def generate_shortened_url
    self.shortened_url = SecureRandom.base58(6)
  end
end

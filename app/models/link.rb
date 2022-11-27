# frozen_string_literal: true

class Link < ApplicationRecord
  SUPPORTED_ORIGIN_AND_EXPECTED_URLS = {
    "http://fake.com" => "http://fake.com",
    "http://www.fake.com" => "http://www.fake.com",
    "https://www.fake.com" => "https://www.fake.com",
    "fake.com" => "http://fake.com",
    "fake.abcdfakeagain" => "http://fake.abcdfakeagain",
    "fake.com/test_api" => "http://fake.com/test_api",
    "//fake.com" => "http://fake.com",
    "://fake.com" => "http://fake.com",
    "htp://fake.com" => "http://fake.com",
    "http//fake.com" => "http://fake.com",
    "https//fake.com" => "https://fake.com",
    "www.fake.com" => "http://www.fake.com",
    "www.fake" => "http://www.fake",
    "www.fake.com/test_api" => "http://www.fake.com/test_api"
  }.freeze

  validates :original_url, presence: true
  validates :shortened_url, uniqueness: true

  before_create :format_original_url, :validate_formatted_url, :generate_shortened_url

  private

  def format_original_url
    self.original_url = Url::Formatter.new(original_url).call
  end

  def generate_shortened_url
    self.shortened_url = SecureRandom.base58(6)
  end

  def validate_formatted_url
    raise ActiveRecord::RecordInvalid unless Url::Validator.new(original_url).valid?
  end
end

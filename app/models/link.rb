# frozen_string_literal: true

class Link < ApplicationRecord
  validates :original_url, presence: true
  validates :shortened_url, uniqueness: true

  before_create :format_original_url, :generate_shortened_url

  private

  def generate_shortened_url
    self.shortened_url = SecureRandom.base58(6)
  end

  def format_original_url
    self.original_url = format_url(original_url)

    raise ActiveRecord::RecordInvalid unless valid_url?(original_url)
  end

  def format_url(url)
    original_scheme = get_original_scheme(url)
    splited_url = url.split("//")
    url = splited_url.length > 1 ? splited_url[1] : splited_url[0]
    url.prepend("://").prepend(original_scheme || "http")
  end

  def get_original_scheme(url)
    %w[https http].find { |valid_scheme| valid_scheme if url.start_with?(valid_scheme) }
  end

  def valid_url?(url)
    return false unless url

    uri = URI.parse(url)
    return false unless uri.host

    valid_uri_scheme?(uri) && valid_uri_suffix?(uri)
  end

  def valid_uri_scheme?(uri)
    return true unless uri&.scheme

    valid_scheme = %w[http https]
    valid_scheme.include?(uri.scheme)
  end

  def valid_uri_suffix?(uri)
    return false unless uri&.host

    uri.host.split(".")[1].present?
  end
end

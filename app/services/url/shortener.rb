# frozen_string_literal: true

# This service only generates random base58 characters
# base58 to the lenght of 6 characters would only serve -> around 38 Billion unique records
# As the records grow larger, the longer it would take to generate a unique key
# Replace this service with more sustainable long term solution
module Url
  class Shortener < Base
    attr_accessor :unique_key_length

    def initialize(url, options = {})
      super
      @unique_key_length = options[:unique_key_length] || 6
    end

    def generate_unique_key
      SecureRandom.base58(unique_key_length)
    end
  end
end

# frozen_string_literal: true

module Url
  class Validator < Base
    def valid?
      return false unless @url

      uri = URI.parse(@url)
      valid_host?(uri) && valid_scheme?(uri) && valid_suffix?(uri)
    end

    private

    def valid_host?(uri)
      uri.host ? true : false
    end

    def valid_scheme?(uri)
      return true unless uri&.scheme

      VALID_SCHEME.include?(uri.scheme)
    end

    def valid_suffix?(uri)
      return false unless uri&.host

      uri.host.split(".")[1].present?
    end
  end
end

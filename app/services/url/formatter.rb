# frozen_string_literal: true

module Url
  class Formatter < Base
    def call
      return @url if @url.blank?

      original_scheme = get_original_scheme(@url)
      raw_url = get_raw_url(@url)
      raw_url.prepend("://").prepend(original_scheme || DEFAULT_SCHEME)
    end

    private

    def get_original_scheme(url)
      VALID_SCHEME.find { |valid_scheme| valid_scheme if url.start_with?(valid_scheme) }
    end

    def get_raw_url(url)
      splited_url = url.split("//")
      splited_url.length > 1 ? splited_url[1] : splited_url[0]
    end
  end
end

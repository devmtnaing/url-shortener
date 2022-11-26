# frozen_string_literal: true

module Url
  class Base
    # Order is important, otherwise only `http` would return for both.
    VALID_SCHEME = %w[https http].freeze

    DEFAULT_SCHEME = "http"

    def initialize(url)
      @url = url
    end
  end
end

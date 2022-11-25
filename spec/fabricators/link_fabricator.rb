# frozen_string_literal: true

Fabricator(:link) do
  original_url { Faker::Internet.url }
end

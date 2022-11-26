# frozen_string_literal: true

class LinkBlueprint < Blueprinter::Base
  identifier :id

  fields :original_url, :shortened_url, :created_at

  field :domain do
    # Temporary solution (domain name should come from a database)
    Rails.env.production? ? "http://sample.com" : "http://localhost:3000"
  end
end

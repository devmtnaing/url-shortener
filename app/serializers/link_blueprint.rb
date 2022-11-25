class LinkBlueprint < Blueprinter::Base
  identifier :id

  fields :original_url, :shortened_url, :domain_name, :created_at
end

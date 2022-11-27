# frozen_string_literal: true

require "rails_helper"

RSpec.describe Url::Shortener do
  let(:url) { Faker::Internet.url }

  context "with default" do
    it "generates a unique key" do
      expect(described_class.new(url).generate_unique_key).not_to be_nil
    end

    it "generates a unique key with length of default" do
      shortener = described_class.new(url)
      expect(shortener.generate_unique_key.length).to eq(shortener.unique_key_length)
    end
  end

  context "with custom length" do
    let(:custom_length) { Faker::Number.between(from: 1, to: 20) }

    it "generates a unique key with length of custom value" do
      shortener = described_class.new(url, unique_key_length: custom_length)
      expect(shortener.generate_unique_key.length).to eq(custom_length)
    end
  end
end

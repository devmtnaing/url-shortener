# frozen_string_literal: true

require "rails_helper"

RSpec.describe Url::Formatter do
  shared_examples_for "successfully formatted" do
    it "formats correctly as expcted url" do
      expect(described_class.new(original_url).call).to eq(expected_url)
    end
  end

  Link::SUPPORTED_ORIGIN_AND_EXPECTED_URLS.each do |k, v|
    it_behaves_like "successfully formatted" do
      let(:original_url) { k }
      let(:expected_url) { v }
    end
  end

  context "when the url is nil" do
    it "returns nil" do
      expect(described_class.new(nil).call).to be_nil
    end
  end

  context "when the url is empty" do
    it "returns nil" do
      expect(described_class.new("").call).to eq("")
    end
  end
end

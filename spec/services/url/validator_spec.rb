# frozen_string_literal: true

require "rails_helper"

RSpec.describe Url::Validator do
  shared_examples_for "successfully validated" do
    it "returns true" do
      expect(described_class.new(url).valid?).to be true
    end
  end

  Link::SUPPORTED_ORIGIN_AND_EXPECTED_URLS.each do |_k, v|
    it_behaves_like "successfully validated" do
      let(:url) { v }
    end
  end

  context "without proper domain" do
    let(:url) { "http://fake" }

    it "returns false" do
      expect(described_class.new(url).valid?).to be false
    end
  end

  context "with wrong http scheme" do
    let(:url) { "/fake.com" }

    it "returns false" do
      expect(described_class.new(url).valid?).to be false
    end
  end
end

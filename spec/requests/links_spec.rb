# frozen_string_literal: true

require "rails_helper"

RSpec.describe "links" do
  describe "#create" do
    let(:url) { "/encode" }
    let(:params) { { original_url: Faker::Internet.url } }
    let(:request) { post url, params: params }

    context "when the request is valid" do
      shared_examples_for "successful creation" do
        it "creates a new link with shortened_url" do
          expect { request }.to change(Link, :count).by(1)
          expect(JSON.parse(response.body)["shortened_url"]).not_to be_nil
        end
      end

      Link::SUPPORTED_ORIGIN_AND_EXPECTED_URLS.each do |k, v|
        it_behaves_like "successful creation" do
          let(:params) { { original_url: k } }
        end
      end
    end

    context "when the request is invalid" do
      let(:params) { { original_url: "/abcd" } }

      it "raises error" do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "#show" do
    let!(:link) { Fabricate.create(:link) }
    let(:shortened_url) { link.shortened_url }
    let(:url) { "/decode/#{shortened_url}" }
    let(:request) { get url }

    context "when the request is valid" do
      it "returns correct response" do
        request
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the request is invalid" do
      let(:shortened_url) { link.shortened_url * 10 }

      it "raises error" do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

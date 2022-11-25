# frozen_string_literal: true

require "rails_helper"

RSpec.describe Link do
  let(:link) { Fabricate.build(:link) }

  describe "validations" do
    context "presence_of" do
      it { is_expected.to validate_presence_of(:original_url) }
    end

    context "uniqueness_of" do
      subject { link }

      it { is_expected.to validate_uniqueness_of(:shortened_url) }
    end
  end

  describe "callbacks" do
    describe "before_create" do
      let(:link) { Fabricate.create(:link) }

      it "generates shortened url" do
        expect(link.shortened_url).not_to be_nil
      end

      it "does not update shortened_url if it is already present" do
        expect { link.update!(original_url: "https://www.google.com") }.not_to change(link, :shortened_url)
      end
    end
  end
end

require "rails_helper"

RSpec.describe Link do
  describe "validations" do
    context "presence_of" do
      it { is_expected.to validate_presence_of(:original_url) }
      it { is_expected.to validate_presence_of(:shortened_url) }
    end

    context "uniqueness_of" do
      subject { described_class.new(original_url: Faker::Internet.url, shortened_url: Faker::Internet.slug) }

      it { is_expected.to validate_uniqueness_of(:shortened_url) }
    end
  end

  describe "methods" do
    let(:link) { Fabricate.build(:link) }

    describe ".generate_shortened_url" do
      it "returns generated shortened_url" do
        expect(link.generate_shortened_url).not_to be_nil
      end
    end
  end
end

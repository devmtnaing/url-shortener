require 'rails_helper'

RSpec.describe Link do
  describe 'validations' do
    context "for presence_of" do
      it { is_expected.to validate_presence_of(:original_url) }
      it { is_expected.to validate_presence_of(:shortened_url) }
    end

    context "for uniqueness_of" do
      subject { described_class.new(original_url: Faker::Internet.url, shortened_url: Faker::Internet.slug) }

      it { is_expected.to validate_uniqueness_of(:shortened_url) }
    end
  end
end

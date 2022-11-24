require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    let!(:link) { create(:link) }

    it { is_expected.to validate_presence_of(:original_url, :shortened_url) }
    it { is_expected.to validate_uniqueness_of(:shortened_url) }
  end
end

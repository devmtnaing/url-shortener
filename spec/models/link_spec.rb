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

      describe ".generate_shortened_url" do
        it "generates shortened url" do
          expect(link.shortened_url).not_to be_nil
        end

        it "does not update shortened_url if it is already present" do
          expect { link.update!(original_url: "https://www.google.com") }.not_to change(link, :shortened_url)
        end
      end

      describe ".format_original_url" do
        let(:expected_url) { Faker::Internet.url }

        shared_examples_for "formatted original url" do
          let(:link) { Fabricate.create(:link, original_url: original_url) }
          it "returns the formatted original url" do
            expect(link.original_url).to eq expected_url
          end
        end

        context "when the original_url is valid" do
          context "with full path without www" do
            it_behaves_like "formatted original url" do
              let(:original_url) { "http://fake.com" }
              let(:expected_url) { "http://fake.com" }
            end
          end

          context "with full path including www" do
            it_behaves_like "formatted original url" do
              let(:original_url) { "http://www.fake.com" }
              let(:expected_url) { "http://www.fake.com" }
            end
          end

          context "with full path including www and using https" do
            it_behaves_like "formatted original url" do
              let(:original_url) { "https://www.fake.com" }
              let(:expected_url) { "https://www.fake.com" }
            end
          end

          context "without proper http scheme" do
            context "without www" do
              it_behaves_like "formatted original url" do
                let(:original_url) { "fake.com" }
                let(:expected_url) { "http://fake.com" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "fake.abcdfakeagain" }
                let(:expected_url) { "http://fake.abcdfakeagain" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "fake.com/test_api" }
                let(:expected_url) { "http://fake.com/test_api" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "//fake.com" }
                let(:expected_url) { "http://fake.com" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "://fake.com" }
                let(:expected_url) { "http://fake.com" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "htp://fake.com" }
                let(:expected_url) { "http://fake.com" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "http//fake.com" }
                let(:expected_url) { "http://fake.com" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "https//fake.com" }
                let(:expected_url) { "https://fake.com" }
              end
            end

            context "with www" do
              it_behaves_like "formatted original url" do
                let(:original_url) { "www.fake.com" }
                let(:expected_url) { "http://www.fake.com" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "www.fake" }
                let(:expected_url) { "http://www.fake" }
              end

              it_behaves_like "formatted original url" do
                let(:original_url) { "www.fake.com/test_api" }
                let(:expected_url) { "http://www.fake.com/test_api" }
              end
            end
          end
        end

        context "when the original_url is invalid" do
          shared_examples_for "raise record invalid error" do
            it "returns the formatted original url" do
              expect { Fabricate.create(:link, original_url: original_url) }.to raise_error(ActiveRecord::RecordInvalid)
            end
          end

          context "without proper domain" do
            it_behaves_like "raise record invalid error" do
              let(:original_url) { "http://fake" }
            end
          end

          context "with wrong http scheme" do
            it_behaves_like "raise record invalid error" do
              let(:original_url) { "/fake.com" }
            end
          end
        end
      end
    end
  end
end

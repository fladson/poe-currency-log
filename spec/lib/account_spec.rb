require "rails_helper"

RSpec.describe Poe::Account do
  describe ".get_account_name" do
    let(:api) { Poe::Connection.api(session) }
    let(:subject) { Poe::Account.get_account_name(api) }

    context "when valid credentials" do
      let(:session) { "valid_session" }

      it "returns a valid account name" do
        VCR.use_cassette "account" do
          expect(subject).to eq("fladsongomes")
        end
      end
    end
  end
end

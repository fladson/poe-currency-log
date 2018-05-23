require "rails_helper"

RSpec.describe Poe::Characters do
  describe ".get_json" do
    let(:api) { Poe::Connection.api(session) }
    let(:subject) { Poe::Characters.get_json(api) }

    context "valid credentials" do
      let(:session) { "valid_session" }

      it "returns a array with all characters" do
        VCR.use_cassette "characters" do
          expect(subject.length).to eq(4)
        end
      end
    end

    context "invalid credentials" do
      let(:session) { "invalid_session" }

      it "raises a ConnectionFailed exception" do
        VCR.use_cassette "invalid characters" do
          expect { subject }.to raise_error(Faraday::ConnectionFailed)
        end
      end
    end
  end
end

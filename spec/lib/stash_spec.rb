require "rails_helper"
require_relative "../../lib/poe/stash"
require_relative "../../lib/poe/connection"

RSpec.describe Stash do
  let(:api) { Connection.api(session) }

  describe ".tabs" do
    let(:subject) { Stash.tabs(api, account_name, league) }

    context "valid params" do
      let(:session) { "valid_session" }
      let(:account_name) { "valid_account_name" }
      let(:league) { "valid_league" }

      it "returns the correct number of tabs" do
        VCR.use_cassette "tabs" do
          expect(subject.size).to eq(16)
        end
      end

      it "returns tabs as String" do
        VCR.use_cassette "tabs" do
          expect(subject.first.class).to be(String)
          expect(subject.first).not_to be_empty
        end
      end
    end
    context "invalid params" do
      describe "invalid session" do
        let(:session) { "invalid_session" }
        let(:account_name) { "valid_account_name" }
        let(:league) { "valid_league" }

        it "raises a ConnectionFailed exception" do
          VCR.use_cassette "invalid session tabs" do
            expect { subject }.to raise_error(Faraday::ConnectionFailed)
          end
        end
      end

      describe "invalid account name" do
        let(:session) { "valid_session" }
        let(:account_name) { "invalid_account_name" }
        let(:league) { "valid_league" }

        it "raises a ConnectionFailed exception" do
          VCR.use_cassette "invalid account name tabs" do
            expect { subject }.to raise_error(Faraday::ConnectionFailed)
          end
        end
      end

      describe "invalid league" do
        let(:session) { "valid_session" }
        let(:account_name) { "valid_account_name" }
        let(:league) { "invalid_league" }

        it "raises a ConnectionFailed exception" do
          VCR.use_cassette "invalid league tabs" do
            expect { subject }.to raise_error(Faraday::ConnectionFailed)
          end
        end
      end
    end
  end

  describe ".num_tabs" do
    let(:subject) { Stash.num_tabs(api, account_name, league) }

    context "valid params" do
      let(:session) { "valid_session" }
      let(:account_name) { "valid_account_name" }
      let(:league) { "valid_league" }

      it "returns the correct number of tabs" do
        VCR.use_cassette "num_tabs" do
          expect(subject).to eq(16)
        end
      end
    end
    context "invalid params" do
      describe "invalid session" do
        let(:session) { "invalid_session" }
        let(:account_name) { "valid_account_name" }
        let(:league) { "valid_league" }

        it "raises a ConnectionFailed exception" do
          VCR.use_cassette "invalid session num_tabs" do
            expect { subject }.to raise_error(Faraday::ConnectionFailed)
          end
        end
      end

      describe "invalid account name" do
        let(:session) { "valid_session" }
        let(:account_name) { "invalid_account_name" }
        let(:league) { "valid_league" }

        it "raises a ConnectionFailed exception" do
          VCR.use_cassette "invalid account name num_tabs" do
            expect { subject }.to raise_error(Faraday::ConnectionFailed)
          end
        end
      end

      describe "invalid league" do
        let(:session) { "valid_session" }
        let(:account_name) { "valid_account_name" }
        let(:league) { "invalid_league" }

        it "raises a ConnectionFailed exception" do
          VCR.use_cassette "invalid league num_tabs" do
            expect { subject }.to raise_error(Faraday::ConnectionFailed)
          end
        end
      end
    end
  end
end

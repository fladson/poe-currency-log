require "rails_helper"

RSpec.describe Poe::Connection do
  describe ".api" do
    let(:session) { "session_id" }
    subject { Poe::Connection.api(session) }

    it "returns a connection with a poe host" do
      expect(subject.host).to eq("www.pathofexile.com")
    end

    it "returns a connection with a POESESSID Cookie" do
      expect(subject.headers["Cookie"]).to eq("POESESSID=#{session}")
    end

    it "returns a json content type connection" do
      expect(subject.headers["Content-type"]).to eq("application/json")
    end
  end
end

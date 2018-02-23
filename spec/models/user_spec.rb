require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:account_name) }
  it { is_expected.to validate_presence_of(:session) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe "encryption" do
    let(:account_name) { "account_name" }
    let(:session) { "session" }
    let(:user) { User.new(account_name: account_name, session: session) }

    it "encrypts account_name" do
      expect(user.encrypted_account_name).not_to be_empty
      expect(user.encrypted_account_name).not_to eq(session)
    end

    it "encrypts session" do
      expect(user.encrypted_session).not_to be_empty
      expect(user.encrypted_session).not_to eq(account_name)
    end

    it "decrypts values correctly" do
      expect(user.account_name).to eq(account_name)
      expect(user.session).to eq(session)
    end
  end
end

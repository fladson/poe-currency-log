# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:currency_logs) }
  it { is_expected.to validate_presence_of(:session) }
  it { is_expected.to validate_length_of(:session).is_equal_to(32) }

  describe 'encryption' do
    let(:account_name) { 'account_name' }
    let(:session) { 'session' }
    let(:user) { User.new(account_name: account_name, session: session) }

    describe 'account_name' do
      subject { user.encrypted_account_name }

      it { is_expected.not_to be_empty }
      it { is_expected.not_to eq session }
    end

    describe 'session' do
      subject { user.encrypted_session }

      it { is_expected.not_to be_empty }
      it { is_expected.not_to eq account_name }
    end

    it 'decrypts values correctly' do
      expect(user.account_name).to eq(account_name)
      expect(user.session).to eq(session)
    end
  end

  describe '#ordered_chart_preferences' do
    it 'returns the chart preferences ordered by sort' do
      user = build(:user, :with_custom_chart_preferences)
      ordered_chart_preferences = user.ordered_chart_preferences

      expect(ordered_chart_preferences.first['currency']).to eq('Exalted Orb')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InitialEmptyCurrencyService do
  subject { described_class.create(user.email) }

  describe '.create' do
    let(:user) { create(:user) }

    it 'creates an empty currency log for each user current leagues' do
      expect(user.currency_logs).to be_empty

      subject

      expect(user.currency_logs.count).to eq(user.current_leagues.count)
    end

    it 'creates empty currency logs' do
      subject

      expect(user.currency_logs.first.data['Chaos Orb']).to be_zero
      expect(user.currency_logs.last.data['Chaos Orb']).to be_zero
    end
  end
end

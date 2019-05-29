# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateInitialEmptyCurrencyService do
  context 'when league is given' do
    let(:league) { 'Standard' }
    subject { described_class.call(user, league) }

    describe '.call' do
      let(:user) { create(:user) }

      it 'creates an empty currency log for the given league' do
        subject

        expect(user.currency_logs.last.league).to eq(league)
      end
    end
  end

  context 'when no league is given' do
    subject { described_class.call(user) }

    describe '.call' do
      let(:user) { create(:user) }

      it 'creates an empty currency log for each user current leagues' do
        subject

        expect(user.currency_logs.count).to eq(user.current_leagues.count)
      end
    end
  end
end

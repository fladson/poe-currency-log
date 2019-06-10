# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueService do
  let(:user) { create(:user) }

  describe '.create' do
    it 'creates the user leagues' do
      described_class.new(user).create

      expect(user.reload.leagues.count).to be(2)
    end

    context 'when permanent league' do
      let(:user) { create(:user, chars: [{ league: 'Standard' }]) }

      it 'creates the user league with the correct type' do
        described_class.new(user).create

        expect(user.reload.leagues.first['type']).to eq('Permanent')
      end
    end

    context 'when temporary league' do
      let(:user) { create(:user, chars: [{ league: 'Abyss' }]) }

      it 'creates the user league with the correct type' do
        allow(ENV).to receive(:[]).with('CURRENT_LEAGUE').and_return('Abyss')
        described_class.new(user).create

        expect(user.reload.leagues.first['type']).to eq('Temporary')
      end
    end

    context 'when custom league' do
      let(:user) { create(:user, chars: [{ league: 'Custom League' }]) }

      it 'creates the user league with the correct type' do
        described_class.new(user).create

        expect(user.reload.leagues.first['type']).to eq('Custom')
      end
    end
  end

  describe '.add' do
    context 'when user already has the league' do
      let(:user) { create(:user, leagues: [{ name: 'Standard' }]) }

      it 'does not add the league' do
        allow(user).to receive(:update)
        described_class.new(user).add('Standard')

        expect(user).not_to have_received(:update)
      end
    end

    context 'when user does not have the league' do
      let(:user) { create(:user, chars: [{ league: 'Standard' }]) }

      before { described_class.new(user).create }

      it 'adds the new league' do
        described_class.new(user).add('Hardcore')

        expect(user.league_names).to eq(%w[Standard Hardcore])
      end
    end
  end

  describe '.flag_league_as_finished' do
    let(:user) { create(:user, chars: [{ league: 'Standard' }]) }

    before { described_class.new(user).create }

    it 'updates the league finished property to true' do
      described_class.new(user).flag_league_as_finished('Standard')

      expect(user.reload.leagues.first['finished']).to be_truthy
    end
  end
end

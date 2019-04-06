# frozen_string_literal: true

require 'rails_helper'

RSpec.describe POE::League do
  describe '.perm_leagues' do
    let(:expected_perm_leagues) do
      [
        'Standard',
        'Hardcore',
        'SSF Standard',
        'SSF Hardcore'
      ]
    end

    it 'returns the correct leagues' do
      expect(described_class.perm_leagues).to eq(expected_perm_leagues)
    end
  end

  describe '.tmp_leagues' do
    let(:expected_tmp_leagues) do
      [
        'Abyss',
        'Hardcore Abyss',
        'SSF Abyss',
        'SSF Abyss HC'
      ]
    end

    it 'returns the correct leagues' do
      allow(ENV).to receive(:[]).with('CURRENT_LEAGUE').and_return('Abyss')

      expect(described_class.tmp_leagues).to eq(expected_tmp_leagues)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe POE::League do
  describe '::STANDARD_LEAGUES' do
    let(:expected_standard_leagues) do
      [
        'Standard',
        'Hardcore',
        'SSF Standard',
        'SSF Hardcore'
      ]
    end

    it 'returns the correct leagues' do
      expect(described_class::STANDARD_LEAGUES).to eq(expected_standard_leagues)
    end
  end

  describe '.temp_leagues' do
    let(:expected_temp_leagues) do
      [
        'Abyss',
        'Abyss Hardcore',
        'SSF Abyss',
        'SSF Abyss Hardcore'
      ]
    end

    it 'returns the correct leagues' do
      allow(ENV).to receive(:[]).with('CURRENT_LEAGUE').and_return('Abyss')

      expect(described_class.temp_leagues).to eq(expected_temp_leagues)
    end
  end
end

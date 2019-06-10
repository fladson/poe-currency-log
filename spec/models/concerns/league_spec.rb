# frozen_string_literal: true

require 'rails_helper'

RSpec.describe League, type: :concern do
  describe '#current_leagues' do
    let(:user) { build(:user, chars: chars) }
    let(:chars) do
      [
        { 'league' => 'SSF Standard' },
        { 'league' => 'Standard' },
        { 'league' => 'Standard' },
        { 'league' => 'Hardcore' },
        { 'league' => 'Abyss' },
        { 'league' => 'Abyss' },
        { 'league' => 'Abyss Hardcore' }
      ]
    end
    let(:expected_leagues) do
      [
        'SSF Standard',
        'Standard',
        'Hardcore',
        'Abyss',
        'Abyss Hardcore'
      ]
    end

    it 'returns the correct leagues' do
      expect(user.current_leagues).to eq(expected_leagues)
    end
  end

  describe '#current_temp_leagues' do
    it 'returns the correct leagues' do
      user = build(:user, chars: chars)

      expect(user.current_temp_leagues).to eq(['Abyss', 'Abyss Hardcore'])
    end
  end

  describe '#standard_leagues' do
    it 'returns the correct leagues' do
      user = build(:user, chars: chars)
      allow(ENV).to receive(:[]).with('CURRENT_LEAGUE').and_return('Abyss')

      expect(user.standard_leagues).to eq(['SSF Standard', 'Standard', 'Hardcore'])
    end
  end

  describe '#past_temp_leagues' do
    it 'returns the correct leagues' do
      user = build(:user, chars: chars, temp_leagues: ['Harbinger', 'Harbinger SSF', 'Abyss', 'Abyss Hardcore'])
      allow(ENV).to receive(:[]).with('CURRENT_LEAGUE').and_return('Abyss')

      expect(user.past_temp_leagues).to eq(['Harbinger', 'Harbinger SSF'])
    end
  end

  describe '#default_league' do
    it 'returns the correct leagues' do
      user = build(:user, chars: chars)

      expect(user.default_league).to eq('Abyss Hardcore')
    end
  end
end

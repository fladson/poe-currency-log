# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:chars) do
    [
      { 'name' => 'tianne_', 'class' => 'Ranger', 'level' => 22, 'league' => 'SSF Standard', 'classId' => 2, 'ascendancyClass' => 0 },
      { 'name' => 'Maeggi', 'class' => 'Ascendant', 'level' => 94, 'league' => 'Standard', 'classId' => 0, 'ascendancyClass' => 1 },
      { 'name' => 'gomes', 'class' => 'Ascendant', 'level' => 94, 'league' => 'Standard', 'classId' => 0, 'ascendancyClass' => 1 },
      { 'name' => 'Ngamason', 'class' => 'Berserker', 'level' => 90, 'league' => 'Hardcore', 'classId' => 1, 'ascendancyClass' => 2 },
      { 'name' => 'Lunna_', 'class' => 'Raider', 'level' => 88, 'league' => 'Abyss', 'classId' => 2, 'ascendancyClass' => 1 },
      { 'name' => 'Maya', 'class' => 'Raider', 'level' => 88, 'league' => 'Abyss Hardcore', 'classId' => 2, 'ascendancyClass' => 1 }
    ]
  end

  it { is_expected.to have_many(:currency_logs) }
  it { is_expected.to have_many(:settings).class_name('UserSetting') }
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

  describe '#current_leagues' do
    context 'when different leagues' do
      it 'returns the correct leagues' do
        user = build(:user, chars: chars)

        expect(user.current_leagues).to eq(['SSF Standard', 'Standard', 'Hardcore', 'Abyss', 'Abyss Hardcore'])
      end
    end

    context 'when some different leagues' do
      it 'returns the correct leagues as uniq' do
        user = build(:user, chars: chars)

        expect(user.current_leagues).to eq(['SSF Standard', 'Standard', 'Hardcore', 'Abyss', 'Abyss Hardcore'])
      end
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
      user = build(:user, chars: chars, temp_leagues: ['Abyss', 'Abyss Hardcore'])

      expect(user.standard_leagues).to eq(['SSF Standard', 'Standard', 'Hardcore'])
    end
  end
end

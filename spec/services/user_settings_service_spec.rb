# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSettingsService do
  describe '.create' do
    let(:user) { build(:user) }

    it 'creates the user settings' do
      described_class.create(user)

      expect(user.settings.count)
        .to eq(POE::CurrencyParser.currency_names.count)
    end
  end
end

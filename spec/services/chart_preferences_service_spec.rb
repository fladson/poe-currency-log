# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChartPreferencesService do
  describe '.create' do
    let(:user) { create(:user) }

    it 'creates the user settings' do
      described_class.create(user.email)

      expect(user.reload.chart_preferences.count)
        .to eq(POE::CurrencyParser.currency_names.count)
    end
  end
end

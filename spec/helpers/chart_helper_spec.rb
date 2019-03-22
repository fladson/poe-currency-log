# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChartHelper, type: :helper do
  describe 'color_for' do
    context 'when user has custom color' do
      let(:setting) { build(:user_setting, color: 'custom') }

      it 'returns the user custom color' do
        expect(color_for(setting)).to eq('custom')
      end
    end

    context 'when user has no custom color' do
      let(:setting) { build(:user_setting) }

      it 'returns the default color for that currency' do
        expect(color_for(setting)).to eq(default_colors[setting.currency])
      end
    end
  end

  describe 'diff' do
    subject { diff(data) }

    context 'when data has only one record' do
      let(:data) { [['datetime', 1]] }

      it { is_expected.to eq '-' }
    end

    context 'when data has more than one record' do
      let(:data) { [['datetime', 10], ['datetime', 5]] }

      it { is_expected.to eq 5 }
    end
  end

  describe 'diff_percent' do
    subject { diff_percent(data) }

    context 'when data has only one record' do
      let(:data) { [['datetime', 1]] }

      it { is_expected.to eq '-' }
    end

    context 'when data has more than one record' do
      let(:data) { [['datetime', 10], ['datetime', 5]] }

      it { is_expected.to eq 100 }
    end
  end
end

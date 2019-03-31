# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChartHelper, type: :helper do
  describe 'color_for' do
    context 'when user has custom color' do
      let(:user) { build(:user, :with_custom_chart_preferences) }

      it 'returns the user custom color' do
        expect(color_for(user.chart_preferences.first)).to eq('custom')
      end
    end

    context 'when user has no custom color' do
      let(:user) { build(:user, :with_chart_preferences) }

      it 'returns the default color for that currency' do
        expect(color_for(user.chart_preferences.first)).to eq(default_colors['Chaos Orb'])
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

  describe 'convert_thousand_to_human' do
    subject { convert_thousand_to_human(value) }

    context 'when value is higher than 999' do
      let(:value) { 1000 }

      it { is_expected.to eq '1K' }
    end

    context 'when value is less than or equal to 999' do
      let(:value) { 999 }

      it { is_expected.to eq '999' }
    end
  end

  describe 'candlestick_data' do
    subject { candlestick_data(data) }

    let(:yesterday) { Date.yesterday }
    let(:today) { Date.today }
    let(:data) do
      [
        [today, 1],
        [today, 0],
        [today, 3],
        [today, 10],
        [today, 5],
        [yesterday, 5],
        [yesterday, 4],
        [yesterday, 3],
        [yesterday, 2],
        [yesterday, 1]
      ]
    end

    let(:expected_data) do
      [
        [today.to_s, [5, 10, 0, 1]],
        [yesterday.to_s, [1, 5, 1, 5]]
      ]
    end

    it { is_expected.to eq expected_data }
  end
end

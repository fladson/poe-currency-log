# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'flash_class' do
    subject { flash_class(level) }

    context 'when level is notice' do
      let(:level) { 'notice' }

      it { is_expected.to eq 'bg-blue-lightest border-blue' }
    end

    context 'when level is success' do
      let(:level) { 'success' }

      it { is_expected.to eq 'bg-green-lightest border-green' }
    end

    context 'when level is error' do
      let(:level) { 'error' }

      it { is_expected.to eq 'bg-red-lightest border-red' }
    end

    context 'when level is alert' do
      let(:level) { 'alert' }

      it { is_expected.to eq 'bg-orange-lightest border-orange' }
    end
  end
end

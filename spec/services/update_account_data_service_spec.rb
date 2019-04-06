# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateAccountDataService do
  context '.call' do
    let(:user) { create(:user, chars: []) }

    it 'updates the account_name and chars' do
      VCR.use_cassette 'account name' do
        VCR.use_cassette 'characters' do
          described_class.call(user)

          expect(user.account_name).to eq('fladsongomes')
          expect(user.chars.count).to eq(4)
        end
      end
    end
  end
end

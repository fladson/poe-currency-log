# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:session) { 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    allow(SetupNewUserWorker).to receive(:perform_async).and_return('nothing')
  end

  describe 'POST #create' do
    it 'calls the SetupNewUserWorker' do
      expect(SetupNewUserWorker).to receive(:perform_async)

      post :create, params: { user: { email: 'foo@email.com', password: 'foo123', password_confirmation: 'foo123', session: session } }
    end
  end

  describe 'PUT #update' do
    before do
      sign_in(user)
    end

    context 'user with settings or currency logs' do
      let(:user) { create(:user, :with_settings_and_currency_logs) }

      it 'does not calls SetupNewUserWorker' do
        expect(SetupNewUserWorker).not_to receive(:perform_async)

        put :update, params: { user: { id: user.id, session: session } }
      end
    end

    context 'user without settings or currency logs' do
      let(:user) { create(:user) }

      it 'calls SetupNewUserWorker ' do
        expect(SetupNewUserWorker).to receive(:perform_async)

        put :update, params: { user: { id: user.id, session: session } }
      end
    end
  end
end

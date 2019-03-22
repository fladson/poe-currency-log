# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:session) { 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    allow(SetupNewUserWorker).to receive(:perform_async).and_return('nothing')
  end

  describe 'POST #create' do
    let(:params) do
      {
        user: {
          email: 'foo@email.com',
          password: 'foo123',
          password_confirmation: 'foo123',
          session: session
        }
      }
    end

    it 'calls the SetupNewUserWorker' do
      post :create, params: params

      expect(SetupNewUserWorker).to have_received(:perform_async)
    end
  end

  describe 'PUT #update' do
    before do
      sign_in(user)
    end

    context 'when user with settings or currency logs' do
      let(:user) { create(:user, :with_settings_and_currency_logs) }

      it 'does not calls SetupNewUserWorker' do
        put :update, params: { user: { id: user.id, session: session } }

        expect(SetupNewUserWorker).not_to have_received(:perform_async)
      end
    end

    context 'when user without settings or currency logs' do
      let(:user) { create(:user) }

      it 'calls SetupNewUserWorker ' do
        put :update, params: { user: { id: user.id, session: session } }

        expect(SetupNewUserWorker).to have_received(:perform_async)
      end
    end
  end
end

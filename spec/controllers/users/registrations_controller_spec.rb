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
end

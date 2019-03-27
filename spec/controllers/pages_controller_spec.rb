# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #dashboard' do
    context 'when unauthorized' do
      it 'returns a 302' do
        get :dashboard

        expect(response).to have_http_status(302)
      end
    end

    context 'when authorized' do
      let(:user) { create(:user, :with_chart_preferences) }

      before do
        sign_in(user)
      end

      context 'when params league is present' do
        it 'pass the league foward' do
          expect_any_instance_of(User).to receive(:currency_stats).with('foo')

          get :dashboard, params: { league: 'foo' }
        end
      end

      context 'when params league is not present' do
        it 'pass the user default league foward' do
          expect_any_instance_of(User)
            .to receive(:currency_stats).with(user.default_league)

          get :dashboard
        end
      end
    end
  end

  describe 'GET #home' do
    it 'returns http success' do
      get :home

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #terms' do
    it 'returns http success' do
      get :terms

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #privacy' do
    it 'returns http success' do
      get :privacy

      expect(response).to have_http_status(:success)
    end
  end
end

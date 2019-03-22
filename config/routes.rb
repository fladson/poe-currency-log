# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  as :user do
    get 'settings', to: 'user_settings#edit', as: :user_settings
    put 'settings', to: 'user_settings#update', as: :update_user_settings

    controller :pages do
      get 'terms' => :terms, as: :terms
      get 'privacy' => :privacy, as: :privacy
      get 'fetch_currency' => :fetch_currency, as: :fetch_currency
      get 'dashboard' => :dashboard, as: :user_root
      get 'dashboard/:league' => :dashboard, as: :dashboard
      get 'leagues_comparison' => :leagues_comparison, as: :leagues_comparison
    end
  end

  Rails.application.routes.draw do
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end

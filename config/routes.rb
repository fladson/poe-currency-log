# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  as :user do
    controller :pages do
      get 'dashboard' => :dashboard, as: :user_root
      get 'dashboard/:league' => :dashboard, as: :dashboard

      get 'fetch_currency' => :fetch_currency, as: :fetch_currency
      get 'leagues_comparison' => :leagues_comparison, as: :leagues_comparison

      get 'terms' => :terms, as: :terms
      get 'privacy' => :privacy, as: :privacy
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

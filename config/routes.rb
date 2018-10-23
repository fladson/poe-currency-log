Rails.application.routes.draw do
  root "pages#home"
  get "fetch_currency", to: "pages#fetch_currency", as: :fetch_currency

  as :user do
    get "dashboard", to: "pages#dashboard", as: :user_root
    get "dashboard/:league", to: "pages#dashboard", as: :dashboard
    get "settings", to: "user_settings#edit", as: :user_settings
    put "settings", to: "user_settings#update", as: :update_user_settings
  end

  Rails.application.routes.draw do
    devise_for :users, controllers: {
      registrations: "users/registrations"
    }
  end

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end

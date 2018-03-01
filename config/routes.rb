Rails.application.routes.draw do
  root "pages#home"

  devise_for :users
  as :user do
    get "dashboard", to: "pages#dashboard", as: :user_root
  end

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end

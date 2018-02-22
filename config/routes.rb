Rails.application.routes.draw do
  root "pages#home"
  get "pages/home"
  get "pages/dashboard"

  devise_for :users
end

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    super do |user|
      create_empty_tabs(user) if user.created_at
    end
  end

  def update
    super do |user|
      create_empty_tabs(user) if user.reload.currency_logs.empty?
    end
  end

  protected

  def create_empty_tabs(user)
    CreateUserSettingsService.perform(user)
    EmptyTabsService.perform(user)
    LogCurrencyWorker.perform_async(user.email)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:session])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:session])
  end
end

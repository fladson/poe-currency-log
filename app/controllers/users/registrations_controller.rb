# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    super do |user|
      SetupNewUserWorker.perform_async(user) if user.persisted?
    end
  end

  def update
    super do |user|
      SetupNewUserWorker.perform_async(user) if user.chart_preferences.blank? || user.currency_logs.empty?
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:session])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:session])
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_raven_context

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:session, :time_zone]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: [:session]
    )
  end

  private

  def set_raven_context
    Raven.user_context(id: current_user.id, email: current_user.email) unless current_user.blank?
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

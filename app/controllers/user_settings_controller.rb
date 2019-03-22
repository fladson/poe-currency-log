# frozen_string_literal: true

class UserSettingsController < ApplicationController
  def edit
    @user_settings = @current_user.settings
  end

  def update
    @user_settings.update(user_settings_params)

    # notification
  end

  def user_settings_params
    params.require(:user_setting).permit(:currency, :color, :sort, :hidden)
  end
end

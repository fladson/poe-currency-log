class UserSettingsController < ApplicationController
  before_action :authenticate
  def edit
    @user_settings = @current_user.settings
  end

  def update
    @user_settings.update(user_settings_params)

    #notification
  end

  def user_settings_params
    params.require(:user_setting).permit(:data)
  end
end

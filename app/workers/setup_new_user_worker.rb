# frozen_string_literal: true

class SetupNewUserWorker
  include Sidekiq::Worker

  def perform(user_email)
    user = User.find_by_email(user_email)
    UpdateAccountDataService.call(user)
    League::Creator.create(user)
    ChartPreferencesService.create(user)
    CreateInitialEmptyCurrencyService.call(user)
    LogCurrencyWorker.perform_async(user_email)
  rescue POE::Error::InvalidSession
    puts ' - Invalid session, updating user valid_credentials to false'
    user = User.find_by_email(user_email)
    user.update(valid_credentials: false)
    SetupNewUserWorker.sidekiq_options retry: 0
  end
end

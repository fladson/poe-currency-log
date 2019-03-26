# frozen_string_literal: true

class SetupNewUserWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user)
    ChartPreferencesService.create(user)
    InitialEmptyCurrencyService.create(user)
    UserDataWorker.perform(user)
    UpdateUserTempLeaguesWorker.perform(user)
    LogCurrencyWorker.perform_async(user)
  end
end

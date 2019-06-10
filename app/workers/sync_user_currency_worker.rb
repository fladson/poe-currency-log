# frozen_string_literal: true

class SyncUserCurrencyWorker
  include Sidekiq::Worker

  def perform(user_email)
    user = User.find_by_email(user_email)
    user.active_leagues.each do |league|
      SyncLeagueCurrencyService.call(user, league)
    end
  rescue POE::Error::InvalidSession
    puts ' - Invalid session, updating user valid_credentials to false'
    user.update(valid_credentials: false)
    LogCurrencyWorker.sidekiq_options retry: 0
  end
end

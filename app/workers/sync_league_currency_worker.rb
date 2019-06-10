# frozen_string_literal: true

class SyncLeagueCurrencyWorker
  include Sidekiq::Worker

  def perform(user_email, league)
    user = User.find_by_email(user_email)
    SyncLeagueCurrencyService.call(user, league)
  rescue POE::Error::InvalidSession
    puts ' - Connection failed, updating user valid_credentials to false'
    user.update(valid_credentials: false)
    LeagueLogCurrencyWorker.sidekiq_options retry: 0
  end
end

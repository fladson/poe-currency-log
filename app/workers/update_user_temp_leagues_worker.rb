# frozen_string_literal: true

class UpdateUserTempLeaguesWorker
  include Sidekiq::Worker

  def perform(user)
    puts '------------------------------------------------------'
    puts " + Fetching data for #{user.email}"
    api = POE::API.new(user.session)

    begin
      temp_leagues = user.temp_leagues | user.current_temp_leagues
      user.update(temp_leagues: temp_leagues)
    rescue POE::Error::InvalidSession
      puts ' - Invalid session, updating user valid_credentials to false'
      user.update(valid_credentials: false)
      LogCurrencyWorker.sidekiq_options retry: 0
    end
  end
end

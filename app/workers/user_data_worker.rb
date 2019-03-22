# frozen_string_literal: true

class UserDataWorker
  include Sidekiq::Worker

  def perform(user)
    puts '------------------------------------------------------'
    puts " + Fetching data for #{user.email}"
    api = POE::API.new(user.session)

    begin
      user.update(account_name: api.account_name)
    rescue POE::Error::InvalidSession
      puts ' - Invalid session, updating user valid_credentials to false'
      user.update(valid_credentials: false)
      LogCurrencyWorker.sidekiq_options retry: 0
    end
  end
end

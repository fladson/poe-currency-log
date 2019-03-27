# frozen_string_literal: true

class UserDataWorker
  include Sidekiq::Worker

  def perform(user_email)
    puts '------------------------------------------------------'
    puts " + Fetching data for #{user_email}"
    user = User.find_by_email(user_email)
    api = POE::API.new(user.session)
    begin
      user.update(account_name: api.account_name, chars: api.chars)
    rescue POE::Error::InvalidSession
      puts ' - Invalid session, updating user valid_credentials to false'
      user.update(valid_credentials: false)
      LogCurrencyWorker.sidekiq_options retry: 0
    end
  end
end

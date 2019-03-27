# frozen_string_literal: true

class LogCurrencyWorker
  include Sidekiq::Worker

  def perform(user_email)
    puts '------------------------------------------------------'
    puts " + Fetching currency for #{user_email}"
    user = User.find_by_email(user_email)
    api = POE::API.new(user.session)

    begin
      user.update(chars: api.chars, valid_credentials: true)
      user.current_leagues.each do |league|
        tabs = api.stash_tabs(user.account_name, league)
        return unless tabs

        currency = POE::CurrencyParser.parse_tabs(tabs)

        CurrencyLog.create(user: user, league: league, data: currency)
      end
    rescue POE::Error::InvalidSession
      puts ' - Invalid session, updating user valid_credentials to false'
      user.update(valid_credentials: false)
      LogCurrencyWorker.sidekiq_options retry: 0
    end
  end
end

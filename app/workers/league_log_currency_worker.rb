# frozen_string_literal: true

class LeagueLogCurrencyWorker
  include Sidekiq::Worker

  def perform(user_email, league)
    puts '------------------------------------------------------'
    puts " + Fetching currency for #{user_email} | League: #{league}"
    user = User.find_by_email(user_email)
    api = POE::API.new(user.session)

    begin
      tabs = api.stash_tabs(user.account_name, league)
      return unless tabs

      currency = POE::CurrencyParser.parse_tabs(tabs)
      CurrencyLog.create(user: user, league: league, data: currency)
    rescue POE::Error::InvalidSession
      puts ' - Connection failed, updating user valid_credentials to false'
      user.update(valid_credentials: false)
      LogCurrencyWorker.sidekiq_options retry: 0
    end
  end
end

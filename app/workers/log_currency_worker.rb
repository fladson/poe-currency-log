class LogCurrencyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email)
    puts "Fetching currency for #{user_email}"
    user = User.find_by_email(user_email)
    api = Poe::Connection.api(user.session)
    begin
      chars = Poe::Characters.get_json(api)
      user.update(chars: chars)
      user.current_leagues.each do |league|
        tabs = Poe::Stash.tabs(api, user.account_name, league)
        currency = Poe::CurrencyParser.parse_tabs(tabs)

        CurrencyLog.create(user: user, league: league, data: currency)
      end
    rescue Faraday::ConnectionFailed
      puts "Connection failed, updating user valid_credentials to false"
      user.update(valid_credentials: false)
    end
  end
end

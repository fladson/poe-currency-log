class LogCurrencyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email)
    puts "Fetching currency for #{user_email}"
    user = User.find_by_email(user_email)
    api = POE::API.new(user.session)
    begin
      chars = api.chars
      user.update(chars: chars)
      user.current_leagues.each do |league|
        tabs = api.stash_tabs(user.account_name, league)
        currency = POE::CurrencyParser.parse_tabs(tabs)

        CurrencyLog.create(user: user, league: league, data: currency)
      end
    rescue POE::Error::InvalidSession
      puts "Connection failed, updating user valid_credentials to false"
      user.update(valid_credentials: false)
    end
  end
end

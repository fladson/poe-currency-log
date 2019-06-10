# frozen_string_literal: true

class SyncLeagueCurrencyService
  attr_reader :user, :league

  def initialize(user, league)
    @user = user
    @league = league
  end

  def self.call(user, league)
    new(user, league).call
  end

  def call
    return unless league['active']

    api = POE::API.new(user.session)
    user.update(chars: api.chars, valid_credentials: true)
    tabs = api.stash_tabs(user.account_name, league['name'])
    return unless tabs

    currency = POE::CurrencyParser.parse_tabs(tabs)
    cl = CurrencyLog.create(user_id: user.id, league: league['name'], data: currency)
    if cl.invalid? && league['active']
      League::Updater.new(user, league['name']).flag_league_as_inactive
    end
  end
end

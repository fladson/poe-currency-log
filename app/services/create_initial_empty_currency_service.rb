# frozen_string_literal: true

class CreateInitialEmptyCurrencyService
  def self.call(user, league = nil)
    return create_for_league(user, league) if league

    user.current_leagues.each do |league|
      create_for_league(user, league)
    end
  end

  private

  def self.create_for_league(user, league)
    CurrencyLog.create(
      user: user,
      data: POE::CurrencyParser.empty_tab,
      league: league
    )
  end
end

module InitialEmptyCurrencyService
  def self.create(user)
    user.current_leagues.each do |league|
      CurrencyLog.create(user: user, data: POE::CurrencyParser.empty_tab, league: league)
    end
  end
end

# frozen_string_literal: true

module InitialEmptyCurrencyService
  def self.create(user_email)
    user = User.find_by_email(user_email)
    user.current_leagues.each do |league|
      CurrencyLog.create(
        user: user,
        data: POE::CurrencyParser.empty_tab,
        league: league
      )
    end
  end
end

# frozen_string_literal: true

module FixNoInitialCurrencyService
  def self.call(user_email, league)
    user = User.find_by_email(user_email)
    user.currency_logs.where(league: league).each do |log|
      POE::CurrencyParser.currency_names.each do |currency|
        if !log.data.keys.include?(currency)
          log.data[currency] = 0
        end
      end
      log.save
    end
  end
end

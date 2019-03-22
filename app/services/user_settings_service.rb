# frozen_string_literal: true

module UserSettingsService
  def self.create(user)
    POE::CurrencyParser.currency_names.each_with_index do |currency, index|
      UserSetting.create(user: user, currency: currency, color: 'default', sort: index)
    end
  end
end

# frozen_string_literal: true

module ChartPreferencesService
  def self.create(user_email)
    user = User.find_by_email(user_email)
    default_chart_preferences = []

    POE::CurrencyParser.currency_names.each_with_index do |currency, index|
      default_chart_preferences << {
        currency: currency,
        sort:     index.to_s,
        color:    'default',
        hidden:   'false'
      }
    end

    user.update(chart_preferences: default_chart_preferences)
  end
end

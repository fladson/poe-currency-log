class CreateUserSettingsService
  def self.perform(user)
    return unless user.settings.blank?
    POE::CurrencyParser.currency_names.each_with_index do |currency, index|
      UserSetting.create(user_id: user.id, currency: currency, color: 'default', sort: index)
    end
  end
end

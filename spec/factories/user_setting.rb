# frozen_string_literal: true

FactoryBot.define do
  factory :user_setting do
    currency { POE::CurrencyParser.currency_names.sample }
    color    { 'default' }
    sort     { rand(0..POE::CurrencyParser.currency_names.count) }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :currency_log do
    league { 'Standard' }
    data   { 'foo' }
  end
end

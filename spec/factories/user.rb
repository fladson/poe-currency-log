# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email                 { FFaker::Internet.email }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { Date.today }
    session               { 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }
    chars                 { [{ league: 'Standard' }, { league: 'Hardcore' }] }

    trait :with_chart_preferences do
      chart_preferences do
        [
          {
            'currency' => 'Chaos Orb',
            'sort' =>     0,
            'color' =>    'default',
            'hidden' =>   false
          }
        ]
      end
    end

    trait :with_custom_chart_preferences do
      chart_preferences do
        [
          {
            'currency' => 'Chaos Orb',
            'sort' =>     1,
            'color' =>    'custom',
            'hidden' =>   true
          },
          {
            'currency' => 'Exalted Orb',
            'sort' =>     0,
            'color' =>    'custom',
            'hidden' =>   true
          }
        ]
      end
    end
  end
end

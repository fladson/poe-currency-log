# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email                 { FFaker::Internet.email }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { Date.today }
    session               { 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }
    chars                 { [{ league: 'Standard' }, { league: 'Hardcore' }] }

    trait :with_settings do
      after(:create) do |user|
        create(:user_setting, user: user)
      end
    end
  end
end

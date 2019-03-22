FactoryBot.define do
  factory :user do
    email                 { FFaker::Internet.email }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { Date.today }
    session               { 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' }
    chars                 { [{ league: "Standard"}, { league: "Hardcore"}] }

    trait :with_settings do
      after(:create) do |user|
        create_list(:user_setting, 2, user: user)
      end
    end

    trait :with_settings_and_currency_logs do
      after(:create) do |user|
        create_list(:user_setting, 2, user: user)
        create(:currency_log, user: user, league: 'Standard', data: rand(1..10000))
      end
    end
  end
end

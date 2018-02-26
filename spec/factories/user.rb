FactoryBot.define do
  factory :user do
    email FFaker::Internet.email
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    session "valid_session"
  end
end

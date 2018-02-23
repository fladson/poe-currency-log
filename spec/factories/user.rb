FactoryBot.define do
  factory :user do
    email FFaker::Internet.email
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    account_name FFaker::Internet.user_name
    session FFaker::Internet.password
    chars {
      [{
        "name" => FFaker::Internet.user_name,
        "league" => "Standard",
        "classId" => 2,
        "ascendancyClass" => 0,
        "class" => "Ranger",
        "level" => 22
      },
      {
        "name" => FFaker::Internet.user_name,
        "league" => "Abyss",
        "classId" => 0,
        "ascendancyClass" => 1,
        "class" => "Ascendant",
        "level" =>94
      }]
    }
  end
end

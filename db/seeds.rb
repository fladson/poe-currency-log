user = User.new(
  email: "test@email.com",
  password: '123456',
  password_confirmation: '123456'
)

user.skip_confirmation!
user.save(validate: false)

user.update_column('chars',
  [{"name"=>"O_taro",
    "class"=>"Hierophant",
    "level"=>74,
    "league"=>"Standard",
    "classId"=>5,
    "experience"=>515938003,
    "ascendancyClass"=>2},
   {"name"=>"Gilmours",
    "class"=>"Hierophant",
    "level"=>82,
    "league"=>"Incursion",
    "classId"=>5,
    "experience"=>1054026315,
    "lastActive"=>true,
    "ascendancyClass"=>2},
   {"name"=>"MayaTheOccultist",
    "class"=>"Occultist",
    "level"=>84,
    "league"=>"Hardcore",
    "classId"=>3,
    "experience"=>1232523912,
    "ascendancyClass"=>1},
   {"name"=>"Maeggi",
    "class"=>"Ascendant",
    "level"=>94,
    "league"=>"Incursion SSF",
    "classId"=>0,
    "experience"=>2661132646,
    "ascendancyClass"=>1},
   {"name"=>"Ngamason",
    "class"=>"Berserker",
    "level"=>90,
    "league"=>"Incursion Hardcore SSF",
    "classId"=>1,
    "experience"=>1934810341,
    "ascendancyClass"=>2},
   {"name"=>"May_a",
    "class"=>"Ascendant",
    "level"=>88,
    "league"=>"Incursion Hardcore",
    "classId"=>0,
    "experience"=>1657121643,
    "ascendancyClass"=>1},
   {"name"=>"Lunna_",
    "class"=>"Raider",
    "level"=>88,
    "league"=>"SSF Standard",
    "classId"=>2,
    "experience"=>1696854096,
    "ascendancyClass"=>1},
    {"name"=>"Lunna_2",
     "class"=>"Raider",
     "level"=>88,
     "league"=>"SSF Hardcore",
     "classId"=>2,
     "experience"=>1696854096,
     "ascendancyClass"=>1}]
)

EmptyTabsService.perform(user)
CreateUserSettingsService.perform(user)

20.times do |i|
  CurrencyLog.create(
    user: user,
    league: [
      "Standard", "Hardcore", "SSF Standard", "SSF Hardcore", "Incursion",
      "Incursion SSF", "Incursion Hardcore", "Incursion Hardcore SSF"
    ].sample,
    created_at: i.days.ago,
    updated_at: i.days.ago,
    data: {
      "Vaal Orb"=>rand(1..100),
      "Chaos Orb"=>rand(1..1000),
      "Regal Orb"=>rand(1..50),
      "Divine Orb"=>rand(1..50),
      "Blessed Orb"=>rand(1..100),
      "Exalted Orb"=>rand(1..100),
      "Silver Coin"=>rand(1..200),
      "Chromatic Orb"=>rand(1..1000),
      "Orb of Chance"=>rand(1..1000),
      "Orb of Fusing"=>rand(1..1000),
      "Orb of Regret"=>rand(1..200),
      "Jeweller's Orb"=>rand(1..5000),
      "Orb of Alchemy"=>rand(1..500),
      "Orb of Scouring"=>rand(1..400),
      "Orb of Annulment"=>rand(1..50),
      "Gemcutter's Prism"=>rand(1..100),
      "Orb of Alteration"=>rand(1..5000),
      "Mirror of Kalandra"=>rand(0..3),
      "Orb of Augmentation"=>rand(1..1000),
      "Glassblower's Bauble"=>rand(1..100),
      "Orb of Transmutation"=>rand(1..2000),
      "Cartographer's Chisel"=>rand(1..300),
      "Master Cartographer's Sextant"=>rand(1..100),
      "Apprentice Cartographer's Sextant"=>rand(1..100),
      "Journeyman Cartographer's Sextant"=>rand(1..100)
    }
  )
end

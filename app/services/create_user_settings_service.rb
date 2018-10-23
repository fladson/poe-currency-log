class CreateUserSettingsService
  def self.perform(user)
    settings = {
      "Chaos Orb" => {
        hidden: false,
        color: 'default',
        position: 0
      },
      "Orb of Fusing" => {
        hidden: false,
        color: 'default',
        position: 1
      },
      "Orb of Alchemy" => {
        hidden: false,
        color: 'default',
        position: 2
      },
      "Exalted Orb" => {
        hidden: false,
        color: 'default',
        position: 3
      },
      "Orb of Annulment" => {
        hidden: false,
        color: 'default',
        position: 4
      },
      "Jeweller's Orb" => {
        hidden: false,
        color: 'default',
        position: 5
      },
      "Chromatic Orb" => {
        hidden: false,
        color: 'default',
        position: 6
      },
      "Regal Orb" => {
        hidden: false,
        color: 'default',
        position: 7
      },
      "Blessed Orb" => {
        hidden: false,
        color: 'default',
        position: 8
      },
      "Divine Orb" => {
        hidden: false,
        color: 'default',
        position: 9
      },
      "Glassblower's Bauble" => {
        hidden: false,
        color: 'default',
        position: 10
      },
      "Gemcutter's Prism" => {
        hidden: false,
        color: 'default',
        position: 11
      },
      "Orb of Scouring" => {
        hidden: false,
        color: 'default',
        position: 12
      },
      "Orb of Regret" => {
        hidden: false,
        color: 'default',
        position: 13
      },
      "Vaal Orb" => {
        hidden: false,
        color: 'default',
        position: 14
      },
      "Cartographer's Chisel" => {
        hidden: false,
        color: 'default',
        position: 15
      },
      "Apprentice Cartographer's Sextant" => {
        hidden: false,
        color: 'default',
        position: 16
      },
      "Journeyman Cartographer's Sextant" => {
        hidden: false,
        color: 'default',
        position: 17
      },
      "Master Cartographer's Sextant" => {
        hidden: false,
        color: 'default',
        position: 18
      },
      "Mirror of Kalandra" => {
        hidden: false,
        color: 'default',
        position: 19
      },
      "Orb of Transmutation" => {
        hidden: false,
        color: 'default',
        position: 20
      },
      "Orb of Alteration" => {
        hidden: false,
        color: 'default',
        position: 21
      },
      "Orb of Chance" => {
        hidden: false,
        color: 'default',
        position: 22
      },
      "Orb of Augmentation" => {
        hidden: false,
        color: 'default',
        position: 23
      },
      "Silver Coin" => {
        hidden: false,
        color: 'default',
        position: 24
      }
    }
    UserSetting.create(user: user, data: settings)
  end
end

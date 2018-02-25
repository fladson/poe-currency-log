class Poe::CurrencyParser
  STANDARD_ITEMS = [
    "Apprentice Cartographer's Sextant", "Blessed Orb", "Blessing of Chayula",
    "Blessing of Esh", "Blessing of Tul", "Blessing of Tul", "Blessing of Xoph",
    "Cartographer's Chisel", "Chaos Orb", "Chromatic Orb", "Divine Orb",
    "Exalted Orb", "Gemcutter's Prism", "Glassblower's Bauble", "Jeweller's Orb",
    "Journeyman Cartographer's Sextant", "Master Cartographer's Sextant",
    "Mirror of Kalandra", "Orb of Alchemy", "Orb of Alteration",
    "Orb of Annulment", "Orb of Augmentation", "Orb of Chance", "Orb of Fusing",
    "Orb of Regret", "Orb of Scouring", "Orb of Transmutation", "Regal Orb",
    "Silver Coin", "Splinter of Chayula", "Splinter of Esh", "Splinter of Tul",
    "Splinter of Uul-Netol", "Splinter of Xoph", "Vaal Orb"
  ].freeze
  LEAGUE_ITEMS = [].freeze
  CURRENCY = (STANDARD_ITEMS | LEAGUE_ITEMS).freeze

  class << self
    def parse_tabs(tabs)
      currency = Hash.new { |hash, key| hash[key] = 0 }
      tabs.each do |tab|
        parse_tab(tab, currency)
      end

      currency
    end

    def parse_tab(tab, currency_hash)
      return if tab =~ /divinationLayout/ || tab =~ /essenceLayout/ || tab =~ /fragmentLayout/
      json = JSON.parse(tab)

      json["items"].each do |item|
        item_name = item["typeLine"]
        currency_hash[item_name] += item["stackSize"] unless !CURRENCY.include?(item_name)
      end
    end
  end
end

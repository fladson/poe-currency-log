module POE
  class CurrencyParser
    STANDARD_CURRENCY = [
      "Apprentice Cartographer's Sextant", "Blessed Orb", "Cartographer's Chisel",
      "Chaos Orb", "Chromatic Orb", "Divine Orb", "Exalted Orb", "Gemcutter's Prism",
      "Glassblower's Bauble", "Jeweller's Orb", "Journeyman Cartographer's Sextant",
      "Master Cartographer's Sextant", "Mirror of Kalandra", "Orb of Alchemy",
      "Orb of Alteration", "Orb of Annulment", "Orb of Augmentation", "Orb of Chance",
      "Orb of Fusing", "Orb of Regret", "Orb of Scouring", "Orb of Transmutation",
      "Regal Orb", "Silver Coin", "Vaal Orb"
    ].freeze
    CURRENT_LEAGUE_CURRENCY = [].freeze
    CURRENCY = (STANDARD_CURRENCY | CURRENT_LEAGUE_CURRENCY).freeze

    class << self
      def parse_tabs(tabs)
        currency = Hash.new { |hash, key| hash[key] = 0 }
        tabs.each do |tab|
          parse_tab(tab, currency)
        end

        currency
      end

      def parse_tab(tab, currency_hash)
        # TODO add other special tabs
        return if tab =~ /divinationLayout/
        json = JSON.parse(tab)
        return if json["items"].blank?
        json["items"].each do |item|
          item_name = item["typeLine"]
          currency_hash[item_name] += item["stackSize"] if CURRENCY.include?(item_name)
        end
      end

      def empty_tab
        Hash[CURRENCY.collect { |currency| [currency, 0] }]
      end
    end
  end
end

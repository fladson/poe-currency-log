# frozen_string_literal: true

module POE
  class CurrencyParser
    STANDARD_CURRENCY = [
      'Chaos Orb', 'Orb of Fusing', 'Orb of Alchemy', 'Exalted Orb',
      'Orb of Annulment', "Jeweller's Orb", 'Chromatic Orb', 'Regal Orb',
      'Blessed Orb', 'Divine Orb', 'Ancient Orb', "Glassblower's Bauble",
      "Gemcutter's Prism", 'Orb of Scouring', 'Orb of Regret', 'Vaal Orb',
      "Cartographer's Chisel", 'Orb of Horizons',
      "Apprentice Cartographer's Sextant", "Journeyman Cartographer's Sextant",
      "Master Cartographer's Sextant", 'Mirror of Kalandra',
      'Orb of Transmutation', 'Orb of Alteration', 'Orb of Chance',
      'Orb of Augmentation', 'Silver Coin'
    ].freeze
    CURRENT_LEAGUE_CURRENCY = [
      'Sepia Oil',
      'Clear Oil',
      'Verdant Oil',
      'Amber Oil',
      'Teal Oil',
      'Azure Oil',
      'Violet Oil',
      'Crimson Oil',
      'Black Oil',
      'Opalescent Oil',
      'Silver Oil',
      'Golden Oil',
    ].freeze
    CURRENCY = (STANDARD_CURRENCY | CURRENT_LEAGUE_CURRENCY).freeze

    class << self
      def parse_tabs(tabs)
        currency = empty_tab
        tabs.each do |tab|
          parse_tab(tab, currency)
        end

        currency
      end

      def parse_tab(tab, currency_hash)
        return if tab =~ Regexp.union(/divinationLayout/, /mapLayout/, /essenceLayout/, /fragmentLayout/, /divinationLayout/)

        json = JSON.parse(tab)
        return if json['items'].blank?

        json['items'].each do |item|
          item_name = item['typeLine']
          currency_hash[item_name] += item['stackSize'] if CURRENCY.include?(item_name)
        end
      end

      def empty_tab
        Hash[CURRENCY.collect { |currency| [currency, 0] }]
      end

      def currency_names
        CURRENCY
      end
    end
  end
end

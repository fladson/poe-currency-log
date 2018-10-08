require "rails_helper"

RSpec.describe POE::CurrencyParser do
  before :all do
    api = POE::API.new("valid_session")

    @tabs = []
    VCR.use_cassette "stash tabs" do
      @tabs = api.stash_tabs("valid_account_name", "valid_league")
    end
  end

  describe ".parse_tabs" do
    it "parses currencies correctly" do
      parsed_currency = POE::CurrencyParser.parse_tabs(@tabs)
      expected_currency = {
        "Journeyman Cartographer's Sextant"=>5,
        "Jeweller's Orb"=>1356,
        "Orb of Chance"=>292,
        "Glassblower's Bauble"=>46,
        "Regal Orb"=>11,
        "Apprentice Cartographer's Sextant"=>13,
        "Divine Orb"=>6,
        "Chaos Orb"=>706,
        "Silver Coin"=>10,
        "Exalted Orb"=>5,
        "Orb of Augmentation"=>124,
        "Vaal Orb"=>14,
        "Cartographer's Chisel"=>45,
        "Blessed Orb"=>54,
        "Orb of Alteration"=>1601,
        "Chromatic Orb"=>437,
        "Orb of Transmutation"=>328,
        "Master Cartographer's Sextant"=>16,
        "Orb of Regret"=>69,
        "Orb of Annulment"=>5,
        "Orb of Alchemy"=>117,
        "Orb of Fusing"=>519,
        "Orb of Scouring"=>76,
        "Gemcutter's Prism"=>9
      }.freeze

      expect(parsed_currency).to eq(expected_currency)
    end
  end

  describe ".parse_tab" do
    it "parses currencies correctly" do
      currency_hash = Hash.new { |hash, key| hash[key] = 0 }
      POE::CurrencyParser.parse_tab(@tabs.first, currency_hash)
      expected_currency = {
        "Journeyman Cartographer's Sextant"=>5,
        "Jeweller's Orb"=>1356,
        "Orb of Chance"=>292,
        "Glassblower's Bauble"=>46,
        "Regal Orb"=>11,
        "Apprentice Cartographer's Sextant"=>13,
        "Divine Orb"=>6,
        "Chaos Orb"=>686,
        "Silver Coin"=>10,
        "Exalted Orb"=>5,
        "Orb of Augmentation"=>124,
        "Vaal Orb"=>14,
        "Cartographer's Chisel"=>25,
        "Blessed Orb"=>34,
        "Orb of Alteration"=>1601,
        "Chromatic Orb"=>437,
        "Orb of Transmutation"=>328,
        "Master Cartographer's Sextant"=>16,
        "Orb of Regret"=>29,
        "Orb of Annulment"=>5,
        "Orb of Alchemy"=>117,
        "Orb of Fusing"=>519,
        "Orb of Scouring"=>76,
        "Gemcutter's Prism"=>9
      }.freeze

      expect(currency_hash).to eq(expected_currency)
    end

    it "sums currencies correctly" do
      currency_hash = Hash.new { |hash, key| hash[key] = 0 }
      POE::CurrencyParser.parse_tab(@tabs.first, currency_hash)
      POE::CurrencyParser.parse_tab(@tabs.second, currency_hash)
      POE::CurrencyParser.parse_tab(@tabs.third, currency_hash)

      expect(currency_hash["Chaos Orb"]).to eq(706)
      expect(currency_hash["Orb of Regret"]).to eq(68)
    end

    it "does not parse special tabs" do
      divination_tab = @tabs[6]
      expect(JSON).not_to receive(:parse).with(divination_tab)

      POE::CurrencyParser.parse_tab(divination_tab, nil)
    end
  end
end

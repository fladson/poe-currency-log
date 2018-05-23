require "rails_helper"

RSpec.describe Poe::CurrencyParser do
  before :all do
    api = Poe::Connection.api("valid_session")
    @tabs = []
    VCR.use_cassette "tabs" do
      @tabs = Poe::Stash.tabs(api, "valid_account_name", "valid_league")
    end
    @tabs.freeze
  end

  describe ".parse_tabs" do
    it "parses currencies correctly" do
      parsed_currency = Poe::CurrencyParser.parse_tabs(@tabs)
      expected_currency = {
        "Journeyman Cartographer's Sextant"=>5,
        "Splinter of Chayula"=>35,
        "Jeweller's Orb"=>1356,
        "Splinter of Esh"=>6,
        "Orb of Chance"=>292,
        "Blessing of Tul"=>1,
        "Glassblower's Bauble"=>46,
        "Splinter of Tul"=>30,
        "Regal Orb"=>11,
        "Apprentice Cartographer's Sextant"=>13,
        "Divine Orb"=>6,
        "Chaos Orb"=>706,
        "Silver Coin"=>10,
        "Exalted Orb"=>5,
        "Orb of Augmentation"=>124,
        "Vaal Orb"=>14,
        "Cartographer's Chisel"=>45,
        "Splinter of Uul-Netol"=>83,
        "Blessed Orb"=>54,
        "Orb of Alteration"=>1601,
        "Chromatic Orb"=>437,
        "Orb of Transmutation"=>328,
        "Master Cartographer's Sextant"=>16,
        "Orb of Regret"=>69,
        "Blessing of Xoph"=>1,
        "Splinter of Xoph"=>78,
        "Orb of Annulment"=>5,
        "Blessing of Esh"=>1,
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
      Poe::CurrencyParser.parse_tab(@tabs.first, currency_hash)
      expected_currency = {
        "Journeyman Cartographer's Sextant"=>5,
        "Splinter of Chayula"=>35,
        "Jeweller's Orb"=>1356,
        "Splinter of Esh"=>6,
        "Orb of Chance"=>292,
        "Blessing of Tul"=>1,
        "Glassblower's Bauble"=>46,
        "Splinter of Tul"=>30,
        "Regal Orb"=>11,
        "Apprentice Cartographer's Sextant"=>13,
        "Divine Orb"=>6,
        "Chaos Orb"=>686,
        "Silver Coin"=>10,
        "Exalted Orb"=>5,
        "Orb of Augmentation"=>124,
        "Vaal Orb"=>14,
        "Cartographer's Chisel"=>25,
        "Splinter of Uul-Netol"=>83,
        "Blessed Orb"=>34,
        "Orb of Alteration"=>1601,
        "Chromatic Orb"=>437,
        "Orb of Transmutation"=>328,
        "Master Cartographer's Sextant"=>16,
        "Orb of Regret"=>29,
        "Blessing of Xoph"=>1,
        "Splinter of Xoph"=>78,
        "Orb of Annulment"=>5,
        "Blessing of Esh"=>1,
        "Orb of Alchemy"=>117,
        "Orb of Fusing"=>519,
        "Orb of Scouring"=>76,
        "Gemcutter's Prism"=>9
      }.freeze

      expect(currency_hash).to eq(expected_currency)
    end

    it "sums currencies correctly" do
      currency_hash = Hash.new { |hash, key| hash[key] = 0 }
      Poe::CurrencyParser.parse_tab(@tabs.first, currency_hash)
      Poe::CurrencyParser.parse_tab(@tabs.second, currency_hash)
      Poe::CurrencyParser.parse_tab(@tabs.third, currency_hash)

      expect(currency_hash["Chaos Orb"]).to eq(706)
      expect(currency_hash["Orb of Regret"]).to eq(68)
    end

    it "does not parse special tabs" do
      divination_tab = @tabs[6]
      expect(JSON).not_to receive(:parse).with(divination_tab)

      Poe::CurrencyParser.parse_tab(divination_tab, nil)
    end
  end
end

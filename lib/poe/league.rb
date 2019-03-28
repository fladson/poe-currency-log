# frozen_string_literal: true

module POE
  module League
    STANDARD_LEAGUES = [
      'Standard',
      'Hardcore',
      'SSF Standard',
      'SSF Hardcore'
    ].freeze

    def self.temp_leagues
      current_league = ENV['CURRENT_LEAGUE']

      [
        current_league,
        "#{current_league} Hardcore",
        "SSF #{current_league}",
        "SSF #{current_league} Hardcore"
      ].freeze
    end
  end
end

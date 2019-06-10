# frozen_string_literal: true

module POE
  module League
    class << self
      def perm_leagues
        [
          'Standard',
          'Hardcore',
          'SSF Standard',
          'SSF Hardcore'
        ].freeze
      end

      def tmp_leagues
        current_league = ENV['CURRENT_LEAGUE']

        [
          current_league,
          "Hardcore #{current_league}",
          "SSF #{current_league}",
          "SSF #{current_league} HC"
        ].freeze
      end

      def event_leagues
        current_league = ENV['CURRENT_EVENT_LEAGUE']

        [
          "#{current_league} (SRE001)",
          "#{current_league} HC (SRE002)",
          "SSF #{current_league} (SRE003)",
          "SSF #{current_league} HC (SRE004)"
        ].freeze
      end
    end
  end
end

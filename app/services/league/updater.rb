# frozen_string_literal: true

module League
  class Updater
    attr_reader :user, :league_name

    def initialize(user, league_name)
      @user = user
      @league_name = league_name
    end

    def flag_league_as_finished
      find_league['finished'] = true

      user.save
    end

    def flag_league_as_inactive
      league = find_league
      if league['inactive_retries'] == 5
        league['active'] = false
      end
      league['inactive_retries'] += 1

      user.save
    end

    def find_league
      user.leagues.find { |league| league['name'] == league_name }
    end
  end
end

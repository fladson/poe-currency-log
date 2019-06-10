# frozen_string_literal: true

module League
  class Creator
    def initialize(user)
      @user = user
    end

    def self.create(user)
      new(user).create
    end

    def create
      user.current_leagues.each do |league_name|
        add(league_name)
      end
    end

    def add(name, active = true, finished = false)
      return if user.league_names.include?(name)

      leagues = user.leagues.blank? ? [] : user.leagues
      leagues << {
        name: name,
        type: league_type(name),
        active: active,
        finished: finished,
        inactive_retries: 0
      }

      user.update(leagues: leagues)
    end

    private

    attr_reader :user

    def league_type(league)
      if POE::League.perm_leagues.include?(league)
        'Permanent'
      elsif POE::League.tmp_leagues.include?(league)
        'Temporary'
      elsif POE::League.event_leagues.include?(league)
        'Event'
      else
        'Custom'
      end
    end
  end
end

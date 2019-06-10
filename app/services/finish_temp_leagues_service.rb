# frozen_string_literal: true

class FinishTempLeaguesService
  def initialize(user)
    @user = user
  end

  def self.call(user)
    new(user).call
  end

  def call
    user.not_finished_temporary_leagues.each do |league|
      league['active'] = false
      league['finished'] = true
    end

    user.save
  end
end

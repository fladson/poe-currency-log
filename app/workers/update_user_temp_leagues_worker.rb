# frozen_string_literal: true

# This worker will be executed after a temp league ends
class UpdateUserTempLeaguesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email)
    user = User.find_by_email(user_email)
    temp_leagues = user.temp_leagues | user.current_temp_leagues

    user.update(temp_leagues: temp_leagues)
  end
end

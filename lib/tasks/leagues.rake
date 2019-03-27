# frozen_string_literal: true

namespace :leagues do
  desc 'Run UpdateUserTempLeaguesWorker for all active and valid users'
  task update_temp_leagues: :environment do
    User.where(valid_credentials: true).find_each do |user|
      next unless user.confirmed?

      UpdateUserTempLeaguesWorker.perform_async(user.email)
    end
  end
end

# frozen_string_literal: true

namespace :log_currency do
  desc 'Run LogCurrencyWorker for all active and valid users'
  task run: :environment do
    User.where(valid_credentials: true).find_each do |user|
      next unless user.confirmed?

      LogCurrencyWorker.perform_async(user.email)
    end
  end
end

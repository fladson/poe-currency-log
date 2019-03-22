# frozen_string_literal: true

namespace :currency_workers do
  desc 'Schedule a LogCurrencyWorker for all active users in their 12am timezone'
  task schedule: :environment do
    QueueUsersWorker.queue_users
  end

  desc 'Run LogCurrencyWorker for all active users'
  task run: :environment do
    InstantWorker.run
  end
end

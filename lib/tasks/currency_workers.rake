namespace :currency_workers do
  desc "Schedule a LogCurrencyWorker for all active users in their 12am timezone"
  task schedule: :environment do
    QueueUsersWorker.queue_users
  end
end

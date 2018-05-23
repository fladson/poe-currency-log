class QueueUsersWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email)
    user = User.find_by_email(user_email)

    LogCurrencyWorker.perform_async(user.email)
  end

  def self.queue_users
    puts "Queueing users"
    User.where(valid_credentials: true).where("updated_at < ?", 6.hours.ago).find_each do |user|
      perform_async(user.email)
    end
  end
end

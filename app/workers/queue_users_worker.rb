class QueueUsersWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email)
    user = User.find_by_email(user_email)
    Time.zone = user.time_zone
    user_time_to_utc = Time.zone.parse("12am").utc
    puts " - Scheduling for #{user.email} at #{user_time_to_utc}"

    LogCurrencyWorker.perform_at(user_time_to_utc, user.email)
  end

  def self.queue_users
    puts "| Queueing users |"
    User.where(valid_credentials: true).where("updated_at < ?", 6.hours.ago).find_each do |user|
      perform_async(user.email)
    end
  end
end

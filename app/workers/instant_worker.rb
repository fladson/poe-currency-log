class InstantWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email)
    user = User.find_by_email(user_email)

    LogCurrencyWorker.perform_async(user.email)
  end

  def self.run
    puts "| Fetching users |"
    User.where(valid_credentials: true).find_each do |user|
      perform_async(user.email)
    end
  end
end

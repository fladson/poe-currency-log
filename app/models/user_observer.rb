class UserObserver < ActiveRecord::Observer
  def after_create(user_email)
    LogCurrencyWorker.perform_async(user_email)
  end
end

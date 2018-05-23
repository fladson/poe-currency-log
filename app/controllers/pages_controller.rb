class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
  end

  def dashboard
  end

  def fetch_currency
    LogCurrencyWorker.perform_async(current_user.email)
    redirect_back(fallback_location: user_root_path)
  end
end

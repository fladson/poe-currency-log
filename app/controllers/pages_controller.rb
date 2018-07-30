class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
  end

  def dashboard
  end

  def league
    render partial: "poe/currency", locals: { league:params[:league] }
  end

  def fetch_currency
    LogCurrencyWorker.perform_async(current_user.email)
    redirect_back(fallback_location: user_root_path)
  end

  def page_params
    params.permit(:league)
  end
end

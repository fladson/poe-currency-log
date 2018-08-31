class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
  end

  def dashboard
    @current_league = params[:query] || current_user.default_league
    @currency_stats = current_user.currency_stats(params[:query] || @current_league)
  end

  def fetch_currency
    LeagueLogCurrencyWorker.perform_async(current_user.email, @current_league)
    redirect_back(fallback_location: user_root_path)
  end

  def page_params
    params.permit(:league, :query)
  end
end

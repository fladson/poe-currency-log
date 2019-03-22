# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def dashboard
    @league = params[:league] || current_user.default_league
    @currency_stats = current_user.currency_stats(@league)
  end

  def fetch_currency
    LeagueLogCurrencyWorker.perform_async(current_user.email, params[:league])
    redirect_back(fallback_location: user_root_path)
  end

  def leagues_comparison; end

  def home; end

  def terms; end

  def privacy; end

  def page_params
    params.permit(:league)
  end
end

# frozen_string_literal: true

module League
  extend ActiveSupport::Concern

  def current_leagues
    chars.map { |char| char['league'] }.uniq
  end

  def league_names
    leagues.map { |league| league['name'] }.uniq
  end

  def default_league
    not_finished_temporary_leagues.first['name']
  end

  def active_leagues
    leagues.select { |league| league['active'] }
  end

  def permanent_leagues
    leagues_by_type('Permanent')
  end

  def not_finished_temporary_leagues
    not_finished(leagues_by_type('Temporary'))
  end

  def not_finished_custom_leagues
    not_finished(leagues_by_type('Custom'))
  end

  def all_leagues_but_not_finished_custom_leagues
    leagues.select { |league| league['type'] != 'Custom' && !league['finished'] }
  end

  def finished_temporary_leagues
    finished(leagues_by_type('Temporary'))
  end

  def finished_custom_leagues
    finished(leagues_by_type('Custom'))
  end

  def league_updated_at(league_name)
    return '' unless league_name

    currency_logs
      .where('lower(league) = ?', deparametrize(league_name).downcase)
      .last
      .created_at
  rescue ActiveRecord::RecordNotFound
    ''
  end

  private

  def leagues_by_type(type)
    leagues.select { |league| league['type'] == type }
  end

  def not_finished(leagues)
    leagues.reject { |league| ActiveModel::Type::Boolean.new.cast(league['finished']) }
  end

  def finished(leagues)
    leagues.select { |league| ActiveModel::Type::Boolean.new.cast(league['finished']) }
  end
end

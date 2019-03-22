# frozen_string_literal: true

class User < ApplicationRecord
  has_many :currency_logs, dependent: :destroy
  has_many :settings, class_name: 'UserSetting', dependent: :destroy
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # unencrypted attrs
  attribute :session
  attribute :account_name
  attr_encrypted :session, :account_name, key: Rails.application.secrets.secret_key_attr_encrypt

  validates :session, presence: true, length: { is: 32 }

  STANDARD_LEAGUES = ['Standard', 'Hardcore', 'SSF Standard', 'SSF Hardcore'].freeze

  def current_leagues
    chars.map { |char| char['league'] }.uniq
  end

  def current_temp_leagues
    current_leagues - STANDARD_LEAGUES
  end

  def standard_leagues
    current_leagues - temp_leagues
  end

  def currency_stats(league)
    currency_logs.progression.by_league(deparametrize(league))
  end

  def default_league
    current_leagues.first
  end

  private

  def deparametrize(str)
    str.split('-').join(' ')
  end

  def to_s
    email
  end
end

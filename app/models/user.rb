# frozen_string_literal: true

class User < ApplicationRecord
  include League
  serialize :chart_preferences
  has_many :currency_logs, dependent: :destroy
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # unencrypted attrs
  attribute :session
  attribute :account_name
  attr_encrypted :session, :account_name, key: Rails.application.secrets.secret_key_attr_encrypt

  validates :session, presence: true, length: { is: 32 }

  def currency_stats(league)
    return unless league

    currency_logs.progression.by_league(deparametrize(league))
  end

  def ordered_chart_preferences
    chart_preferences.sort_by{ |k| k['sort'].to_i }
  end

  private

  def deparametrize(str)
    str.split('-').join(' ')
  end

  def to_s
    email
  end
end

class User < ApplicationRecord
  has_many :currency_logs, dependent: :destroy
  has_many :settings, class_name: "UserSetting", dependent: :destroy
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # unencrypted attrs
  attribute :session
  attribute :account_name
  attr_encrypted :session, :account_name, key: Rails.application.secrets.secret_key_attr_encrypt

  validates :session, presence: true
  validate :check_credentials

  STANDARD_LEAGUES = ["Standard", "Hardcore", "SSF Standard", "SSF Hardcore"]

  def current_leagues
    chars.map { |char| char["league"] }.uniq
  end

  def current_temp_league
    (current_leagues - STANDARD_LEAGUES).pop
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

  def check_credentials
    begin
      api = POE::API.new(session)

      self.account_name = api.account_name
      self.chars = api.chars
      self.valid_credentials = true
      self.temp_leagues.push(current_temp_league) unless self.temp_leagues.include?(current_temp_league)
    rescue POE::Error::InvalidSession
      errors.add(:session, "is invalid")
      Rails.logger.info("Invalid user session: #{self}")
    end
  end

  def deparametrize(str)
    str.split("-").join(" ")
  end

  def to_s
    email
  end
end

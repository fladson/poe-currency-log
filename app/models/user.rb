class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # unencrypted attrs
  attribute :session
  attribute :account_name
  attr_encrypted :session, :account_name, key: Rails.application.secrets.secret_key_attr_encrypt
  validates :session, presence: true
  validate :check_credentials

  private

  def check_credentials
    begin
      api = Poe::Connection.api(session)
      self.chars = Poe::Characters.get_json(api)
      self.valid_credentials = true
      self.account_name = Poe::Account.get_account_name(api)
    rescue Faraday::ConnectionFailed
      errors.add(:session, "is invalid")
      Rails.logger.info("Invalid user session: #{self}")
    end
  end

  def to_s
    email
  end

end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # unencrypted attrs
  attribute :session
  attribute :account_name
  attr_encrypted :session, :account_name, key: Rails.application.secrets.secret_key_attr_encrypt
  validates :session, :account_name, presence: true
end

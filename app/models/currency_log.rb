class CurrencyLog < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :data, scope: [:user_id, :league]
end

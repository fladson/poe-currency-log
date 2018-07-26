class CurrencyLog < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :data, scope: [:user_id, :league]

  scope :for_league, -> (league) { where(league: league) }
  scope :timeline_order, -> { order(:created_at) }

  def self.format_currencies
    pluck(:data).inject do |result, item|
      result.each_with_object({}) do |(key, value), hash|
        hash[key] = [*value] + [item[key]]
      end
    end
  end
end

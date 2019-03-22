# frozen_string_literal: true

class CurrencyLog < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :data, scope: %i[user_id league]

  def self.progression
    @progression_query ||= CurrencyProgressionQuery.new(self)
  end
end

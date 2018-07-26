class CurrencyProgressionQuery
  attr_reader :relation

  def initialize(relation)
    @relation = relation.extending(Scopes)
  end

  def by_league(league)
    @relation.timeline_order.by_league(league).formatted
  end

  module Scopes
    def by_league(league)
      where(league: league)
    end

    def timeline_order
      order(:created_at)
    end

    def formatted
      pluck(:data).inject do |result, item|
        result.each_with_object({}) do |(key, value), hash|
          hash[key] = [*value] + [item[key]]
        end
      end
    end
  end
end

class CurrencyProgressionQuery
  attr_reader :relation

  def initialize(relation)
    @relation = relation.extending(Scopes)
  end

  def by_league(league)
    @relation.timeline_order.by_league(league).formatted
  end

  module Chart
    def self.inject_created_at((data, created_at))
      data.each_with_object({}) do |(key, value), hash|
        hash[key] = [[created_at.to_s, value]]
      end
    end

    def self.accumulate(acc, data)
      acc.each_with_object({}) do |(key, value), hash|
        hash[key] = [*data[key]] + value
      end
    end

    def self.generate(relation, field, date = :created_at)
      relation.pluck(field, date)
        .map(&method(:inject_created_at))
        .inject(&method(:accumulate))
    end
  end

  module Scopes
    def by_league(league)
      where("lower(league) = ?", league.downcase)
    end

    def timeline_order
      order(:created_at)
    end

    def formatted
      Chart.generate(self, :data)
    end
  end
end

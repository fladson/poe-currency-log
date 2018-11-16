class CurrencyProgressionQuery
  attr_reader :relation

  def initialize(relation)
    @relation = relation.extending(Scopes)
  end

  def by_league(league)
    @relation.timeline_order.by_league(league).formatted
  end

  def without_date(league)
    @relation.timeline_order.by_league(league).formatted_without_date
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

    def self.new_accumulate(acc, data)
      acc.each_with_object({}) do |(key, value), hash|
        hash[key] = [*data[key]].push(value).flatten
      end
    end

    def self.generate(relation, field, date = :created_at)
      relation.pluck(field, date)
        .map(&method(:inject_created_at))
        .inject(&method(:accumulate))
    end

    def self.generate_without_date(relation, field)
      relation.pluck(field)
        .inject(&method(:new_accumulate))
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

    def formatted_without_date
      Chart.generate_without_date(self, :data)
    end
  end
end

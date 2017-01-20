class Event < ApplicationRecord

  def self.count_by_week
    unscope(:order)
      .group(start_week_function.to_sql).count
  end

  def self.total_hours_by_week
    unscope(:order)
      .group(start_week_function.to_sql).sum(:duration)
      .transform_values { |sum| sum / 3600.0 }
  end

  def self.start_week_function
    Arel::Nodes::NamedFunction.new('YEARWEEK', [
      table[:starts_at], 3
    ])
  end

  def self.table
    @table ||= Event.arel_table
  end
end

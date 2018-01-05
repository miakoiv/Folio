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
    Arel::Nodes::NamedFunction.new('DATE_FORMAT', [
      table[:starts_at], Arel::Nodes::Quoted.new('%xW%v')
    ])
  end

  def self.table
    @table ||= Event.arel_table
  end
end

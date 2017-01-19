class Customer < ApplicationRecord

  def self.count_by_age
    joins(:person).unscope(:order)
      .where.not(people: {date_of_birth: nil})
      .group(Person.age_function.to_sql).count
  end

  def self.count_by_gender
    joins(:person).unscope(:order)
      .group(Person.gender_function.to_sql).count
      .transform_keys { |k| {'m' => '♂', 'f' => '♀', '' => ''}[k] }
  end

  def self.count_by_month
    unscope(:order)
      .group(creation_month_function.to_sql).count
  end

  # This method establishes the count of customers created before
  # the earliest one (last one) in whatever relation this is called on.
  # NOTE: to successfully unscope :created_at, it must have been applied
  #       as a hash condition or through Arel
  def self.starting_count
    earliest = last
    unscope(where: :created_at).where(
      creation_month_function.lt(
        table.project(creation_month_function).where(table[:id].eq(earliest.id))
      )
    ).count
  end

  def self.creation_month_function
    Arel::Nodes::NamedFunction.new('DATE_FORMAT', [
      table[:created_at], Arel::Nodes::Quoted.new('%Y-%m')
    ])
  end

  def self.table
    @table ||= Customer.arel_table
  end
end

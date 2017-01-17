class Customer < ApplicationRecord

  def self.count_by_age
    joins(:person).unscope(:order)
      .where.not(people: {date_of_birth: nil})
      .group(Person.age_function.to_sql).count
  end

  def self.count_by_gender
    joins(:person).unscope(:order).group(:gender).count
  end
end

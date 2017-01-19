class Person < ApplicationRecord

  def self.latest
    Person.reorder(created_at: :desc).first
  end

  def self.count_by_age
    unscope(:order)
      .where.not(date_of_birth: nil)
      .group(age_function.to_sql).count
  end

  def self.count_by_gender
    unscope(:order)
      .group(gender_function.to_sql).count
      .transform_keys { |k| {'m' => '♂', 'f' => '♀', '' => ''}[k] }
  end


  # Arel function to calculate a person's age.
  def self.age_function
    Arel::Nodes::NamedFunction.new('TIMESTAMPDIFF', [
      Arel.sql('YEAR'),
      table[:date_of_birth],
      Arel::Nodes::NamedFunction.new('CURDATE', [])
    ])
  end

  # Arel function to coalesce genders into {''|'f'|'m'}
  def self.gender_function
    Arel::Nodes::NamedFunction.new('COALESCE', [
      table[:gender], Arel::Nodes::Quoted.new('')
    ])
  end

  def self.table
    @table ||= Person.arel_table
  end
end

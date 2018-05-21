require 'searchlight/adapters/action_view'

class PersonSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Person.includes(:images, :customers, postcode: :municipality)
  end

  def options
    super.tap do |opts|
      opts['parental'] ||= '0'
    end
  end

  def search_parental
    if checked?(parental)
      query.where(Person.arel_table[:children_count].gt(0))
    else
      query.where(children_count: 0)
    end
  end

  def search_keyword
    query.where(
      Person.arel_table[:last_name].matches("#{keyword}%")
      .or(Person.arel_table[:first_names].matches("#{keyword}%")))
  end

  def search_phone
    query.where(Person.arel_table[:phone].matches("%#{phone}%"))
  end

  def search_address
    query.where(Person.arel_table[:address].matches("%#{address}%"))
  end

  def search_postcode
    query.where(postcode: postcode)
  end

  def search_year_of_birth
    query.where(
      Arel::Nodes::NamedFunction.new('YEAR', [Person.arel_table[:date_of_birth]])
      .eq(year_of_birth)
    )
  end

  def search_expired
    if checked?(expired)
      query.where(Person.arel_table[:updated_at].lt(1.year.ago))
    else
      query
    end
  end
end

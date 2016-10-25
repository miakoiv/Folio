require 'searchlight/adapters/action_view'

class PersonSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Person.includes(:images, postcode: :municipality)
  end

  def search_keyword
    query.where(%q{
      people.last_name LIKE :keyword OR
      people.identification LIKE :keyword
    }, keyword: "#{keyword}%")
  end

  def search_municipalities
    query.where(municipality_id: municipalities)
  end

  def search_year_of_birth
    query.where('YEAR(date_of_birth) = ?', year_of_birth)
  end
end

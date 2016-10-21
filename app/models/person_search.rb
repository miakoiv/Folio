require 'searchlight/adapters/action_view'

class PersonSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Person.includes(postcode: :municipality)
  end

  def search_keyword
    query.where(%q{
      people.last_name LIKE :keyword OR
      people.identification LIKE :keyword
    }, keyword: "#{keyword}%")
  end

  def search_municipality_id
    query.where(postcodes: {municipality_id: municipality_id})
  end
end

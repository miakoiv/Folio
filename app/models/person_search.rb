class PersonSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Person.all
  end

  def search_keyword
    query.where(%q{
      people.last_name LIKE :keyword OR
      people.identification LIKE :keyword
    }, keyword: "#{keyword}%")
  end
end

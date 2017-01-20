require 'searchlight/adapters/action_view'

class CustomerSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Customer.includes(:person)
  end

  def search_unit
    query.where(unit: unit)
  end

  def search_since_date
    query.where(Customer.table[:created_at].gteq(since_date))
  end

  def search_until_date
    query.where(Customer.table[:created_at].lt(until_date))
  end

  def search_contacts
    query.where(contact: contacts)
  end
end

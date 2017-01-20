require 'searchlight/adapters/action_view'

class EventSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Event.includes(customer: :unit)
  end

  def search_user
    query.where(user: user)
  end

  def search_unit
    query.where(customers: {unit: unit})
  end

  def search_users
    query.where(user: users)
  end

  def search_customer
    query.where(customer: customer)
  end

  def search_since_date
    query.where(Event.arel_table[:starts_at].gteq(since_date))
  end

  def search_until_date
    query.where(Event.arel_table[:starts_at].lt(until_date))
  end
end

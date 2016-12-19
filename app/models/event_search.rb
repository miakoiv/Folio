require 'searchlight/adapters/action_view'

class EventSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Event.includes(:liaison)
  end

  def search_user_id
    query.where(user_id: user_id)
  end

  def search_liaison_id
    query.where(liaison_id: liaison_id)
  end

  def search_since_date
    query.where(Event.arel_table[:starts_at].gteq(since_date))
  end

  def search_until_date
    query.where(Event.arel_table[:starts_at].lt(until_date))
  end
end

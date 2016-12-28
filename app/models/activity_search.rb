require 'searchlight/adapters/action_view'

class ActivitySearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Activity.includes(:user, :resource)
  end

  def search_unit
    query.where(unit_id: unit)
  end

  def search_user
    query.where(user_id: user)
  end

  def search_resource_type
    query.where(resource_type: resource_type)
  end

  def search_resource_id
    query.where(resource_id: resource_id)
  end
end

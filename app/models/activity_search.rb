require 'searchlight/adapters/action_view'

class ActivitySearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Activity.includes(:whodunnit, :resource)
  end

  def search_unit
    query.where(unit_id: unit)
  end

  def search_whodunnit
    query.where(whodunnit_id: whodunnit)
  end
end

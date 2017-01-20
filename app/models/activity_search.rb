require 'searchlight/adapters/action_view'

class ActivitySearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Activity.includes(:whodunnit, :resource)
  end

  def search_unit
    query.where(unit: unit)
  end

  def search_whodunnit
    query.where(whodunnit: whodunnit)
  end

  def search_upto_date
    query.where(
      Arel::Nodes::NamedFunction.new('DATE', [Activity.arel_table[:created_at]])
      .lteq(upto_date)
    )
  end
end

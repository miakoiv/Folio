require 'searchlight/adapters/action_view'

class CustomerSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Customer.includes(:person)
  end


end

require 'searchlight/adapters/action_view'

class MemoSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Memo.joins(:deliveries)
  end

  def search_keyword
    query.where(
      Memo.arel_table[:title].matches("%#{keyword}%")
      .or(Memo.arel_table[:content].matches("%#{keyword}%"))
    )
  end

  def search_recipients
    query.where(deliveries: {recipient: recipients})
  end
end

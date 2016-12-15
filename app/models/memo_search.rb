require 'searchlight/adapters/action_view'

class MemoSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Memo.joins(:deliveries)
  end

  def search_keyword
    query.where(%q{
      memos.title LIKE :keyword OR
      memos.content LIKE :keyword
    }, keyword: "%#{keyword}%")
  end

  def search_recipients
    query.where(deliveries: {recipient: recipients})
  end
end

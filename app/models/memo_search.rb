require 'searchlight/adapters/action_view'

class MemoSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Memo.all
  end

  def search_keyword
    query.where(%q{
      memos.title LIKE :keyword OR
      memos.content LIKE :keyword
    }, keyword: "%#{keyword}%")
  end

  def search_sender
    query.where(sender_id: sender)
  end

  def search_recipients
    query.joins(:recipients).where(users: {id: recipients})
  end
end

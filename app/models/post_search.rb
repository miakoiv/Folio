require 'searchlight/adapters/action_view'

class PostSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Post.includes(:author, :comments)
  end

  def search_unit
    query.where(unit: unit)
  end

  def search_keyword
    query.where(
      Post.arel_table[:title].matches("%#{keyword}%")
      .or(Post.arel_table[:content].matches("%#{keyword}%"))
    )
  end
end

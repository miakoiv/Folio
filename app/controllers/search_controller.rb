class SearchController < ApplicationController
  def index
    @people = PersonSearch.new(@search_params).results
    @memos = MemoSearch.new(@search_params).results
  end
end

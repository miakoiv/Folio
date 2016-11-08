class ReportsController < ApplicationController

  # GET /
  def index
    @people = PersonStats.new
  end
end

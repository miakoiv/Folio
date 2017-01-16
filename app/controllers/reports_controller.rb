class ReportsController < ApplicationController

  # GET /reports
  def index
  end

  # GET /reports/people
  def people
    @people = PersonStats.new
  end

  # GET /reports/customers
  def customers
  end
end

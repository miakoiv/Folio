class ReportsController < ApplicationController

  # GET /reports
  def index
  end

  # GET /reports/people
  def people
    @people = Person.all
    @by_age    = ChartData.new(@people, :count_by_age)
    @by_gender = ChartData.new(@people, :count_by_gender)
  end

  # GET /reports/customers
  def customers
    @customer_search_params = customer_search_params
    @search = CustomerSearch.new(@customer_search_params)
    @customers = @search.results
    @by_age    = ChartData.new(@customers, :count_by_age)
    @by_gender = ChartData.new(@customers, :count_by_gender)
  end

  protected
    def customer_search_params
      params.fetch(:customer_search) {{}}.permit(
        # add search terms here...
      ).merge(unit: current_unit)
    end
end

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
    @by_month  = ChartData.new(@customers, :count_by_month)
    @starting_count = @customers.starting_count
  end

  # GET /reports/events
  def events
    @event_search_params = event_search_params
    @search = EventSearch.new(@event_search_params)
    @events = @search.results
    @by_week             = ChartData.new(@events, :count_by_week)
    @total_hours_by_week = ChartData.new(@events, :total_hours_by_week)
  end

  protected
    def customer_search_params
      params.fetch(:customer_search) {{}}.permit(
        :since_date, :until_date, contacts: []
      ).merge(unit: current_unit)
    end

    # Including current unit in search params excludes events without
    # a customer as the associated unit is found through customers.
    def event_search_params
      params.fetch(:event_search) {{}}.permit(
        :since_date, :until_date, users: []
      ).merge(unit: current_unit)
    end
end

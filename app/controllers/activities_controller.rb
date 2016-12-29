class ActivitiesController < ApplicationController

  # GET /activities
  # GET /activities.json
  def index
    @activity_search_params = search_params
    @search = ActivitySearch.new(@activity_search_params)
    @activities = @search.results.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /activities/sidebar
  def sidebar
    @resource = GlobalID::Locator.locate(params[:gid])
    @activities = @resource.activities.at(current_unit).limit(20)
  end

  protected
    def search_params
      params.fetch(:activity_search) {{}}.permit(
        {whodunnit: []}, :upto_date
      ).merge(
        unit: current_unit.id
      )
    end
end

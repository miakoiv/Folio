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

  protected
    def search_params
      params.fetch(:activity_search) {{}}.permit(
        :user, :resource_type, :resource_id
      ).merge(
        unit: current_unit.id
      )
    end
end

class MunicipalitiesController < ApplicationController

  def index
    q = params[:q]
    @municipalities = q.present? ? Municipality.query(q) : Municipality.none

    respond_to do |format|
      format.json { @municipalities }
    end
  end
end

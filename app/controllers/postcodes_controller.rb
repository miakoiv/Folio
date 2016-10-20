class PostcodesController < ApplicationController

  def index
    q = params[:q]
    @postcodes = q.present? ? Postcode.query(q) : Postcode.none

    respond_to do |format|
      format.json { @postcodes }
    end
  end
end

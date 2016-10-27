class EventsController < ApplicationController

  before_action :set_liaison, only: [:new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events.all
  end

  # GET /liaisons/2/events/new
  def new
    @event = @liaison.events.for(current_user).build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /liaisons/2/events
  # POST /liaisons/2/events.json
  def create
    @event = @liaison.events.for(current_user).build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: t('.notice', event: @event) }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: t('.notice', event: @event) }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @liaison = @event.liaison
    @event.destroy

    respond_to do |format|
      format.html { redirect_to @liaison, notice: t('.notice', event: @event) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liaison
      @liaison = current_unit.liaisons.find(params[:liaison_id])
    end

    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(
        :event_type_id, :starts_at, :ends_at, :all_day, :title, :description
      )
    end
end

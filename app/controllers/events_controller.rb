class EventsController < ApplicationController

  # See config/routes.rb about the nesting of resources.
  before_action :set_liaison, only: [:search, :new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events
  end

  # GET /liaisons/2/events
  # GET /liaisons/2/events.json
  def search
    @search = EventSearch.new(search_params)
    @events = @search.results

    respond_to do |format|
      format.json { render :index }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /liaisons/2/events/new
  def new
    @event = @liaison.events.build(event_params)
  end

  # GET /events/1/edit
  def edit
  end

  # POST /liaisons/2/events
  # POST /liaisons/2/events.json
  def create
    @event = @liaison.events.build(event_params)
    @event.creator = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: t('.notice', event: @event) }
        format.js
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.js { render :new }
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
        format.js
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.js { render :edit }
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

  protected
    def search_params
      params.slice(:since_date, :until_date).merge(user_id: current_user)
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
      params.fetch(:event) {{}}.permit(
        :event_type_id, :starts_at, :set_duration, :ends_at, :title, :description
      )
    end
end

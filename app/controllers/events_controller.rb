class EventsController < ApplicationController

  # Context is liaison if present, current user otherwise.
  before_action :set_context, only: [:search, :new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events
  end

  # GET /users/2/events/search.json
  # GET /liaisons/2/events/search.json
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

  # GET /users/2/events/new
  # GET /liaisons/2/events/new
  def new
    @event = @context.events.build(event_params)
  end

  # GET /events/1/edit
  def edit
  end

  # POST /users/2/events/new
  # POST /users/2/events/new.json
  # POST /liaisons/2/events
  # POST /liaisons/2/events.json
  def create
    @event = @context.events.build(event_params)
    @event.user ||= current_user

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
    def set_context
      @liaison = current_unit.liaisons.find_by(id: params[:liaison_id])
      @context = @liaison || current_user
    end

    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.fetch(:event) {{}}.permit(
        :event_type_id, :title, :description,
        :starts_at, :ends_at, :duration,
        compound_starts_at_attributes: [:date, :time]
      )
    end
end

class EventsController < ApplicationController

  # Context is customer if present, current user otherwise.
  before_action :set_context, only: [:search, :new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events
  end

  # GET /users/2/events/search.json
  # GET /customers/2/events/search.json
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
  # GET /customers/2/events/new
  def new
    @event = @context.events.for(current_user).build(event_params)
  end

  # GET /events/1/edit
  def edit
    track @event, @event.context
  end

  # POST /users/2/events/new
  # POST /users/2/events/new.json
  # POST /customers/2/events
  # POST /customers/2/events.json
  def create
    @event = @context.events.for(current_user).build(event_params)

    respond_to do |format|
      if @event.save
        track @event, @context
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
        track @event, @event.context
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

  # DELETE /events/1.js
  def destroy
    track @event, @event.context
    @event.destroy

    respond_to do |format|
      format.js
    end
  end

  protected
    def search_params
      params.slice(:since_date, :until_date).merge(user: current_user)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_context
      @customer = current_unit.customers.find_by(id: params[:customer_id])
      @context = @customer || current_user
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

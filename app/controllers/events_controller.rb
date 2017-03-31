class EventsController < ApplicationController

  before_action :set_context, only: [:search, :new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /users/2/events/search.json
  # GET /customers/2/events/search.json
  def search
    @search = EventSearch.new(search_params)
    @events = @search.results.in_context_of(current_unit, current_user, @context)

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
    @event = @context.events.at(current_unit).for(current_user).build(event_params)
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
    @event = @context.events.at(current_unit).for(current_user).build(event_params)

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
      params.slice(:since_date, :until_date)
    end

  private
    # Sets context to associate new events to an object, and for
    # scoping search results.
    def set_context
      @customer = Customer.find_by(id: params[:customer_id])
      @user = User.find_by(id: params[:user_id])
      @context = @customer || @user
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

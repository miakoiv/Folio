class StepsController < ApplicationController
  before_action :set_customer, only: [:new, :create]
  before_action :set_step, only: [:edit, :update, :destroy]

  # GET /customers/2/steps/new
  def new
    @step = @customer.steps.build(reached_at: Date.current)
  end

  # GET /steps/1/edit.js
  def edit
    track @step, @step.customer
  end

  # POST /customers/2/steps.js
  def create
    @step = @customer.steps.build(step_params)

    respond_to do |format|
      if @step.save
        track @step, @step.customer
        format.js
      else
        format.js { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1.js
  def update
    @customer = @step.customer

    respond_to do |format|
      if @step.update(step_params)
        track @step, @step.customer
        format.js
      else
        format.js { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1.js
  def destroy
    track @step, @step.customer
    @step.destroy

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = current_unit.customers.find(params[:customer_id])
    end

    def set_step
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(
        :milestone_id, :reached_at, :notes
      )
    end
end

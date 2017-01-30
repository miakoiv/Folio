class CustomersController < ApplicationController

  before_action :set_person, only: [:new, :create]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers/1
  # GET /customers/1.json
  def show
    disable_editing!
    track @customer
  end

  # GET /people/2/customers/new
  def new
    @customer = @person.customers.at(current_unit).build(contact: current_user)
  end

  # GET /customers/1/edit
  def edit
    track @customer
  end

  # POST /people/2/customers
  # POST /people/2/customers.json
  def create
    @customer = @person.customers.at(current_unit).build(customer_params)

    respond_to do |format|
      if @customer.save
        track @customer
        format.html { redirect_to @customer, notice: t('.notice', customer: @customer) }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        track @customer
        format.html { redirect_to @customer, notice: t('.notice', customer: @customer) }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @person = @customer.person
    track @customer
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to @person, notice: t('.notice', customer: @customer) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:person_id])
    end

    def set_customer
      @customer = current_unit.customers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(
        :contact_id, :status_id, :referrer_id, :referrer_info, :started_at
      )
    end
end

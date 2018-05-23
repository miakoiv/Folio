class PoliciesController < ApplicationController

  before_action :set_policy, only: [:show, :edit, :update, :destroy, :accept]

  # GET /policies
  # GET /policies.json
  def index
    @policies = Policy.all
  end

  # GET /policies/1
  # GET /policies/1.json
  def show
    disable_editing!
  end

  # GET /policies/new
  def new
    @policy = Policy.new
  end

  # GET /policies/1/edit
  def edit
  end

  # POST /policies
  # POST /policies.json
  def create
    @policy = Policy.new(policy_params)

    respond_to do |format|
      if @policy.save
        track @policy
        format.html { redirect_to @policy, notice: t('.notice', policy: @policy) }
        format.json { render :show, status: :created, location: @policy }
      else
        format.html { render :new }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policy/1
  # PATCH/PUT /policy/1.json
  def update
    respond_to do |format|
      if @policy.update(policy_params)
        track @policy
        format.html { redirect_to @policy, notice: t('.notice', policy: @policy) }
        format.json { render :show, status: :ok, location: @policy }
      else
        format.html { render :edit }
        format.json { render json: @policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy/1
  # DELETE /policy/1.json
  def destroy
    track @policy
    @policy.destroy

    respond_to do |format|
      format.html { redirect_to policies_path, notice: t('.notice', policy: @policy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy
      @policy = Policy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_params
      params.require(:policy).permit(
        :title, :content, :mandatory
      )
    end
end

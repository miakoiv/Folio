class LiaisonsController < ApplicationController

  before_action :set_person, only: [:new, :create]
  before_action :set_liaison, only: [:show, :edit, :update, :destroy]

  # GET /liaisons/1
  # GET /liaisons/1.json
  def show
    disable_editing!
  end

  # GET /people/2/liaisons/new
  def new
    @liaison = @person.liaisons.for(current_user).build
  end

  # GET /liaisons/1/edit
  def edit
  end

  # POST /people/2/liaisons
  # POST /people/2/liaisons.json
  def create
    @liaison = @person.liaisons.for(current_user).build(liaison_params)
    @liaison.creator = current_user

    respond_to do |format|
      if @liaison.save
        format.html { redirect_to @liaison, notice: t('.notice', liaison: @liaison) }
        format.json { render :show, status: :created, location: @liaison }
      else
        format.html { render :new }
        format.json { render json: @liaison.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /liaisons/1
  # PATCH/PUT /liaisons/1.json
  def update
    respond_to do |format|
      if @liaison.update(liaison_params)
        format.html { redirect_to @liaison, notice: t('.notice', liaison: @liaison) }
        format.json { render :show, status: :ok, location: @liaison }
      else
        format.html { render :edit }
        format.json { render json: @liaison.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liaisons/1
  # DELETE /liaisons/1.json
  def destroy
    @person = @liaison.person
    @liaison.destroy

    respond_to do |format|
      format.html { redirect_to @person, notice: t('.notice', liaison: @liaison) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:person_id])
    end

    def set_liaison
      @liaison = current_unit.liaisons.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def liaison_params
      params.require(:liaison).permit(
        :status_id, :referrer_id, :referrer_info
      )
    end
end

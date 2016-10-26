class LiaisonsController < ApplicationController

  before_action :set_person
  before_action :set_liaison, only: [:show, :edit, :update, :destroy]

  # GET /people/1/liaisons
  # GET /people/1/liaisons.json
  def index
    @liaisons = @person.liaisons
  end

  # GET /people/1/liaisons/2
  # GET /people/1/liaisons/2.json
  def show
    disable_editing!
  end

  # GET /people/1/liaisons/new
  def new
    @liaison = @person.liaisons.build
  end

  # GET /people/1/liaisons/2/edit
  def edit
  end

  # POST /people/1/liaisons
  # POST /people/1/liaisons.json
  def create
    @liaison = @person.liaisons.build(liaison_params)

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

  # PATCH/PUT /people/1/liaisons/2
  # PATCH/PUT /people/1/liaisons/2.json
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

  # DELETE /people/1/liaisons/2
  # DELETE /people/1/liaisons/2.json
  def destroy
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
      @liaison = @person.liaisons.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def liaison_params
      params.require(:liaison).permit(
        :status, :referrer_id, :referrer_info, :notes
      )
    end
end

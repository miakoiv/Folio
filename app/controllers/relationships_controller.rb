class RelationshipsController < ApplicationController

  before_action :set_person, only: [:new, :create]
  before_action :set_relationship, only: [:edit, :update, :destroy]

  # GET /people/2/relationships/new
  def new
    @relationship = @person.relationships.build
    @relationship.parent = Person.find_or_initialize_by(id: params[:parent_id])
  end

  # GET /relationships/1/edit
  def edit
  end

  # POST /people/2/relationships
  # POST /people/2/relationships.json
  def create
    @relationship = @person.relationships.build(relationship_params)

    respond_to do |format|
      if @relationship.save
        format.html { redirect_to @relationship, notice: t('.notice', relationship: @relationship) }
        format.js
        format.json { render :show, status: :created, location: @relationship }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    respond_to do |format|
      if @relationship.update(relationship_params)
        format.html { redirect_to @relationship, notice: t('.notice', relationship: @relationship) }
        format.js
        format.json { render :show, status: :ok, location: @relationship }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1.js
  def destroy
    @person = @relationship.person
    @relationship.destroy

    respond_to do |format|
      format.js
    end
  end

  # POST /relationships/parent.json
  def parent
    @parent = Person.find_or_initialize_by(id: params[:parent_id])

    respond_to do |format|
      format.json { render @parent }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:person_id])
    end

    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.require(:relationship).permit(
        :parent_id, :relation_id,
        parent_attributes: [
          :id, :creator_id,
          :last_name, :first_names, :address, :postcode_id,
          :municipality_id, :phone, :email
        ]
      )
    end
end

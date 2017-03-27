class RelationshipsController < ApplicationController

  before_action :set_person, only: [:new, :create]
  before_action :set_relationship, only: [:edit, :update, :destroy, :parent]

  # GET /people/2/relationships/new
  def new
    if relationship_params.empty?
      @relationship = @person.relationships.build
      @relationship.parent = Person.new

      render :new
    else
      params = relationship_params.slice(:relation_id, :parent_id)
      @relationship = @person.relationships.build(params)
      @relationship.parent = Person.find_or_initialize_by(id: params[:parent_id])

      render :parent
    end
  end

  # GET /relationships/1/edit
  def edit
    if relationship_params.empty?
      render :edit
    else
      params = relationship_params.slice(:relation_id, :parent_id)
      @relationship.attributes = params
      @relationship.parent = Person.find_or_initialize_by(id: params[:parent_id])

      render :parent
    end
  end

  # POST /people/2/relationships
  # POST /people/2/relationships.json
  def create
    @relationship = @person.relationships.build(relationship_params)

    respond_to do |format|
      if @relationship.save
        track @relationship.parent, @person
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
        track @relationship.parent, @relationship.person
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
    track @relationship.parent, @person
    @relationship.destroy

    respond_to do |format|
      format.js
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
      params.fetch(:relationship) {{}}.permit(
        :parent_id, :relation_id, :legal_guardian,
        parent_attributes: [
          :id, :last_name, :first_names, :address, :postcode_id,
          :municipality_id, :phone, :email
        ]
      )
    end
end

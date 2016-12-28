class NotesController < ApplicationController

  before_action :set_customer, only: :create
  before_action :set_note, only: [:edit, :update, :destroy]

  # GET /notes/1/edit.js
  def edit
    track @note
  end

  # POST /customers/2/notes.js
  def create
    @note = @customer.notes.by(current_user).build(note_params)

    respond_to do |format|
      if @note.save
        track @note
        format.js
      else
        format.js { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1.js
  def update
    @customer = @note.customer

    respond_to do |format|
      if @note.update(note_params)
        track @note
        format.js
      else
        format.js { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1.js
  def destroy
    track @note
    @note.destroy

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = current_unit.customers.find(params[:customer_id])
    end

    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :content)
    end
end

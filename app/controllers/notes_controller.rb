class NotesController < ApplicationController

  before_action :set_liaison, only: :create
  before_action :set_note, only: [:edit, :update, :destroy]

  # GET /notes/1/edit.js
  def edit
  end

  # POST /liaisons/2/notes.js
  def create
    @note = @liaison.notes.build(note_params)
    @note.creator = current_user

    respond_to do |format|
      if @note.save
        format.js
      else
        format.js { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1.js
  def update
    @liaison = @note.liaison

    respond_to do |format|
      if @note.update(note_params)
        format.js
      else
        format.js { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1.js
  def destroy
    @note.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liaison
      @liaison = current_unit.liaisons.find(params[:liaison_id])
    end

    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :content)
    end
end

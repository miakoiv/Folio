class DocumentsController < ApplicationController

  # GET /documents/1
  # GET /documents/1.js
  def show
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @documentable = find_documentable
    @document = @documentable.documents.build(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: t('.notice', document: @document) }
        format.json
      else
        format.html { render :new }
        format.json {
          render json: @document.errors[:attachment], status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: t('.notice', document: @document) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Finds the associated documentable by looking through params.
    def find_documentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          klass = $1.classify.constantize
          return klass.find(value)
        end
      end
      nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:attachment)
    end
end

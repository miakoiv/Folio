class ImagesController < ApplicationController

  # GET /images/1
  # GET /images/1.js
  def show
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @imageable = find_imageable
    @image = @imageable.images.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: t('.notice', image: @image) }
        format.json
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url, notice: t('.notice', image: @image) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Finds the associated imageable by looking through params.
    def find_imageable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          klass = $1.classify.constantize
          return klass.find(value)
        end
      end
      nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:attachment)
    end
end

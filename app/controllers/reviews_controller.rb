class ReviewsController < ApplicationController

  before_action :set_customer, only: :create
  before_action :set_review, only: [:edit, :update, :save, :destroy]

  # GET /reviews/1/edit.js
  def edit
    track @review, @review.customer
  end

  # POST /customers/2/reviews.js
  def create
    @review = @customer.reviews.by(current_user).build(review_params)
    @review.content = current_unit.review_template.content if current_unit.review_template.present?

    respond_to do |format|
      if @review.save
        track @review, @review.customer
        format.js
      else
        format.js { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1.js
  def update
    @customer = @review.customer

    respond_to do |format|
      if @review.update(review_params)
        track @review, @review.customer
        format.js
      else
        format.js { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1/save.js
  def save
    respond_to do |format|
      if @review.update(review_params)
        format.js
      else
        format.js { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1.js
  def destroy
    track @review, @review.customer
    @review.destroy

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = current_unit.customers.find(params[:customer_id])
    end

    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:title, :content, :published_at)
    end
end

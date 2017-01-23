class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @post_search_params = search_params
    @search = PostSearch.new(@post_search_params.merge(unit: current_unit))
    @posts = @search.results.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /posts/1/edit.js
  def edit
    track @post
  end

  # POST /posts.js
  def create
    @post = current_unit.posts.by(current_user).build(post_params)

    respond_to do |format|
      if @post.save
        track @post
        format.js
      else
        format.js { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1.js
  def update
    respond_to do |format|
      if @post.update(post_params)
        track @post
        format.js
      else
        format.js { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1.js
  def destroy
    track @post
    @post.destroy

    respond_to do |format|
      format.js
    end
  end

  protected
    def search_params
      params.fetch(:post_search) {{}}.permit(:keyword)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(
        :unit_id, :author_id, :title, :content
      )
    end
end

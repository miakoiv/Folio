class CommentsController < ApplicationController

  before_action :set_post, only: :create

  # POST /posts/2/comments.js
  def create
    @comment = @post.comments.by(current_user).build(comment_params)

    respond_to do |format|
      if @comment.save
        track @comment, @post
        format.js
      else
        format.js { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_unit.posts.find(params[:post_id])
    end

    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end

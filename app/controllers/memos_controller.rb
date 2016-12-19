class MemosController < ApplicationController

  before_action :set_memo, only: [:show, :edit, :update, :destroy]

  # GET /memos
  # GET /memos.json
  def index
    @memo_search_params = search_params.merge(recipients: [current_user, current_unit])
    @search = MemoSearch.new(@memo_search_params)
    @memos = @search.results.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /memos/sent
  # GET /memos/sent.json
  def sent
    @memos = current_user.sent_memos.page(params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    disable_editing!
    @memo.collect_by(current_user)
  end

  # GET /memos/new
  def new
    @memo = current_user.sent_memos.build
  end

  # GET /memos/1/edit
  def edit
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = current_user.sent_memos.build(memo_params)

    respond_to do |format|
      if @memo.save
        @memo.collect_by(current_user)
        format.html { redirect_to memos_path, notice: t('.notice', memo: @memo) }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: t('.notice', memo: @memo) }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: t('.notice', memo: @memo) }
      format.json { head :no_content }
    end
  end

  protected
    def search_params
      params.fetch(:memo_search) {{}}.permit(:keyword)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(
        :icon, :title, :content, recipient_ids: []
      )
    end
end

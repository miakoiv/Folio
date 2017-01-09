class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy,
    :confirm_two_factor, :confirm_two_factor_update]

  # GET /users
  # GET /users.json
  def index
    authorize_action_for User, unit: current_unit
    @users = current_unit.users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize_action_for @user
    disable_editing!
    track @user
  end

  # GET /users/new
  def new
    authorize_action_for User, unit: current_unit
    @user = current_unit.users.build(locale: I18n.default_locale)
  end

  # GET /users/1/edit
  def edit
    authorize_action_for @user
    track @user
  end

  # POST /users
  # POST /users.json
  def create
    authorize_action_for User, unit: current_unit
    @user = current_unit.users.build(user_params)

    respond_to do |format|
      if @user.save
        track @user
        format.html { redirect_to @user, notice: t('.notice', user: @user) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize_action_for @user

    respond_to do |format|
      if @user.update(user_params)
        track @user
        format.html {
          if @user.unconfirmed_two_factor?
            redirect_to confirm_two_factor_path(@user)
          else
            redirect_to @user, notice: t('.notice', user: @user)
          end
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize_action_for @user
    track @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: t('.notice', user: @user) }
      format.json { head :no_content }
    end
  end

  # GET /users/1/two_factor/confirm
  def confirm_two_factor
  end

  # PUT /users/1/two_factor
  def confirm_two_factor_update
    respond_to do |format|
      format.html {
        if @user.confirm_two_factor!(params[:code])
          redirect_to @user, notice: t('.notice', user: @user)
        else
          render :confirm_two_factor
        end
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email, :last_name, :first_names, :locale,
        :password, :password_confirmation,
        :activates_at, :expires_at,
        :two_factor_enabled
      )
    end
end

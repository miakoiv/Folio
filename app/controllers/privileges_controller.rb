class PrivilegesController < ApplicationController
  before_action :set_user

  authority_actions create: 'update', destroy: 'update'

  def create
    @privilege = Privilege.new(privilege_params)
    authorize_action_for @privilege, unit: @user.unit
    @user.add_role @privilege.name, @privilege.resource
    @user.roles.reload

    respond_to do |format|
      format.js { render :update }
    end
  end

  def destroy
    @privilege = Privilege.new(name: params[:name], resource_gid: params[:resource_gid])
    authorize_action_for @privilege, unit: @user.unit
    @user.remove_role @privilege.name, @privilege.resource

    respond_to do |format|
      format.js { render :update }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def privilege_params
      params.require(:privilege).permit(
        :name, :resource_gid
      )
    end
end

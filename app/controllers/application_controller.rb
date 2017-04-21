class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!
  before_action :set_unit, if: -> { user_signed_in? }
  before_action :set_search_params
  after_action :prepare_unobtrusive_flash

  # Handle security violations gracefully.
  def authority_forbidden(error)
    Authority.logger.warn(error.message)

    respond_to do |format|
      format.js { render 'shared/forbidden', status: :forbidden }
      format.html {
        redirect_to request.referrer.presence || root_path,
          alert: t('authority.forbidden')
      }
    end
  end

  # Check if current user has two factor authentication left unconfirmed,
  # and has gone outside UsersController.
  def need_2fa_confirm?
    !request.xhr? && current_user.unconfirmed_two_factor? &&
      controller_name != 'users'
  end
  helper_method :need_2fa_confirm?

  # Set a flag to disable editing in rendered forms.
  def disable_editing!
    @disable_editing = true
  end

  # The unit the current user is working at, see #set_unit.
  def current_unit
    @current_unit
  end
  helper_method :current_unit

  # Units accessible by the current user, see #set_unit.
  def accessible_units
    @accessible_units ||= Unit.accessible_by(current_user)
  end
  helper_method :accessible_units

  # Tracks activity for given resource in given context, with current unit
  # and current user. Stores the action taken on given resource, storing any
  # changes made as differences, except changes between two blank values.
  # The newly created activity is also rendered and broadcast to current unit.
  def track(resource, context = nil)
    differences = resource.previous_changes
      .except('encrypted_password', 'created_at', 'updated_at')
      .reject { |attribute, value| value.reject(&:blank?).empty? }

    activity = Activity.create(
      unit: current_unit,
      whodunnit: current_user,
      action: action_name,
      resource: resource,
      context: context || resource,
      differences: differences
    )
    ActivityChannel.broadcast_to current_unit,
      ApplicationController.render(partial: 'activities/item', object: activity, as: :activity)
  end

  private
    def set_locale
      I18n.locale = params[:locale] ||
        user_signed_in? && current_user.locale.presence ||
        I18n.default_locale
    end

    # Sets the current unit from user specified id, which is saved into session,
    # falling back to the primary unit if the specified unit is not accessible.
    def set_unit
      session[:unit_id] = params[:unit_id] if params[:unit_id].present?
      @current_unit = session[:unit_id].present? &&
        accessible_units.find(session[:unit_id]) ||
        current_user.unit
    end

    def set_search_params
      @search_params = params.fetch(:search_params) {{}}
    end
end

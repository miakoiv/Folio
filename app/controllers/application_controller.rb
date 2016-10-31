class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!
  before_action :set_unit
  after_action :prepare_unobtrusive_flash

  # Set a flag to disable editing in rendered forms.
  def disable_editing!
    @disable_editing = true
  end

  # The unit the current user is working at, see #set_unit.
  def current_unit
    @current_unit
  end
  helper_method :current_unit

  private
    def set_locale
      I18n.locale = params[:locale] ||
        user_signed_in? && current_user.locale.presence ||
        I18n.default_locale
    end

    def set_unit
      @current_unit = current_user.try(:unit)
    end
end

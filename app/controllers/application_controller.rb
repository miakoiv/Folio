class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!
  after_action :prepare_unobtrusive_flash

  # Set a flag to disable editing in rendered forms.
  def disable_editing!
    @disable_editing = true
  end

  private
    def set_locale
      I18n.locale = params[:locale] ||
        user_signed_in? && current_user.locale.presence ||
        I18n.default_locale
    end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_action :prepare_unobtrusive_flash

  include TurbolinksCacheControl

  # Set a flag to disable editing in rendered forms.
  def disable_editing!
    @disable_editing = true
  end

end

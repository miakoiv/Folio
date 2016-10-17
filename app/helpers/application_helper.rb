module ApplicationHelper

  # Include this helper in the layout to control Turbolinks caching behavior.
  # See app/controllers/concerns/turbolinks_cache_control.rb
  def turbolinks_cache_control_meta_tag
    tag :meta, name: 'turbolinks-cache-control',
      content: @turbolinks_cache_control || 'cache'
  end

  # Controllers may set @disable_editing to have forms render with
  # disabled controls. This helper should be used in views since
  # the instance variable may be nil.
  def editing_disabled?
    @disable_editing
  end

  # Helper to generate titles for pages and menu entries
  def title(klass, options = {})
    klass.model_name.human(options).capitalize
  end

  # Generates an options array for locale select tags.
  def locale_options
    I18n.available_locales.map do |l|
      [I18n.with_locale(l) { t('i18n.language.name') }, l]
    end
  end
end

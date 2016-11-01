module ApplicationHelper

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

  # Generates options from a single container object to populate select
  # widgets that use Ajax queries having no other options defined.
  def options_from_current(container, value_method = :id, text_method = :name)
    return [] if container.nil?
    [
      [value_for_collection(container, text_method),
        value_for_collection(container, value_method)]
    ]
  end

  # Generates a nav tab list item pointing to tab id.
  def nav_tab(id, text, options = {})
    content_tag :li, options do
      link_to text, "##{id}", data: {toggle: 'tab'}
    end
  end

  def content_animation
    {
      class: 'animate-panel', data: {
        child: 'content > .row > div',
        effect: 'fadeIn',
        delay: 0.25
      }
    }
  end

  # Generates a Haml-compliant hash for a collapsible element
  # that is initially shown if object#method returns true.
  def collapsible(object, method)
    collapse_in = object.try(method) ? 'collapse in' : 'collapse'
    {class: collapse_in}
  end

  # Generates a telephone link
  def tel_to(text, number, options = {})
    link_to text, "tel:#{number.split.join '-'}", options
  end

  # Generates a mailto link
  def mail_to(text, email, options = {})
    link_to text, "mailto:#{email}", options
  end

  # Generates an options array for locale select tags.
  def locale_options
    I18n.available_locales.map do |l|
      [I18n.with_locale(l) { t('i18n.language.name') }, l]
    end
  end
end

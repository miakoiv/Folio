# This concern adds methods to deal with models having a translated
# name attribute, stored in different fields suffixed by the locale,
# as in name_fi, name_sv, name_en, etc.
#
# Including Translatable adds a localized_name_method class method
# that returns the method name corresponding to the given locale,
# defaulting to I18n.default_locale if no matching attribute can be found.
# This method is used to define the default scope and a name method.
#
module Translatable
  extend ActiveSupport::Concern

  included do
    default_scope { order(localized_name_method) }
  end

  class_methods do
    def localized_name_method(locale = I18n.locale)
      method = "name_#{locale}"
      has_attribute?(method) && method || "name_#{I18n.default_locale}"
    end
  end

  def name(locale = I18n.locale)
    send(self.class.localized_name_method(locale))
  end
end

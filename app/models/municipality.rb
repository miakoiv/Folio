class Municipality < ApplicationRecord

  has_many :postcodes

  # Naming by locale, if available.
  def name
    try("name_#{I18n.locale}") || name_fi
  end
end

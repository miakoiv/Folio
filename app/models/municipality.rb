class Municipality < ApplicationRecord

  has_many :postcodes

  default_scope { order(:name_fi) }

  scope :query, -> (q) {
    where('name_fi LIKE :q OR name_sv LIKE :q', q: "#{q}%")
  }

  # Naming by locale, if available.
  def name
    try("name_#{I18n.locale}") || name_fi
  end

  # Text method for JSON responses to select2
  def text
    name
  end

  def to_s
    name
  end
end

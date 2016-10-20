class Postcode < ApplicationRecord
  self.primary_key = :code

  belongs_to :municipality

  scope :query, -> (q) {
    where 'code LIKE :q OR name_fi LIKE :q OR name_sv LIKE :q', q: "#{q}%"
  }

  # Naming by locale, if available.
  def name
    try("name_#{I18n.locale}") || name_fi
  end

  # Text method for JSON responses to select2
  def text
    "#{code} #{name}"
  end

  def to_s
    text
  end
end

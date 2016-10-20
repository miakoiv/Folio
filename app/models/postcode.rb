class Postcode < ApplicationRecord
  self.primary_key = :code

  belongs_to :municipality

  scope :lookup, -> (term) {
    where('code LIKE :term OR town LIKE :term', term: "#{term}%")
  }

  # Naming by locale, if available.
  def name
    try("name_#{I18n.locale}") || name_fi
  end

  def to_s
    "#{code} #{name}"
  end
end

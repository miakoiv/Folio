class Postcode < ApplicationRecord
  self.primary_key = :code

  include Translatable

  belongs_to :municipality

  default_scope { unscope(:order).order(:code, localized_name_method) }

  scope :query, -> (q) {
    where(
      arel_table[:code].matches("#{q}%")
      .or(arel_table[localized_name_method].matches("#{q}%"))
    )
  }

  # Text method for JSON responses to select2
  def text
    "#{code} #{name}"
  end

  def to_s
    name
  end
end

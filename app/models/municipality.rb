class Municipality < ApplicationRecord

  include Translatable

  has_many :postcodes

  scope :query, -> (q) {
    where(arel_table[localized_name_method].matches("#{q}%"))
  }

  # Text method for JSON responses to select2
  def text
    name
  end

  def to_s
    name
  end
end

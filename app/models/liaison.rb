class Liaison < ApplicationRecord

  belongs_to :unit
  belongs_to :person
  belongs_to :status
  belongs_to :referrer, optional: true

  # Scope for restricting liaisons to a single unit.
  scope :at, -> (unit) { where(unit: unit) }
end

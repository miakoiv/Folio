class Liaison < ApplicationRecord

  belongs_to :user
  belongs_to :person

  belongs_to :status
  belongs_to :referrer, optional: true
  has_many :events

  default_scope { order(created_at: :desc) }

  # Scope for restricting liaisons to a single unit.
  scope :at, -> (unit) { where(unit: unit) }


  def to_s
    "#{created_at.to_date} / #{person}"
  end
end

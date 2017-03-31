class EventType < ApplicationRecord

  include Translatable

  # Event scope is decided by its event type. See delegations in Event.
  enum event_scope: {customer: 0, personal: 1, shared: 2}

  has_many :events

  default_scope { reorder(:id) }
  scope :customer_or_personal, -> { where(event_scope: [0, 1]) }
  scope :personal_or_shared, -> { where(event_scope: [1, 2]) }


  def to_s
    name
  end
end

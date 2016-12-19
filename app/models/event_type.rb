class EventType < ApplicationRecord

  include Translatable

  has_many :events

  default_scope { reorder(:id) }

  # Event type 0 is restricted to user events.
  scope :for_liaisons, -> { where.not(id: 0) }

  def to_s
    name
  end
end

class EventType < ApplicationRecord

  include Translatable

  has_many :events

  default_scope { reorder(:id) }

  def to_s
    name
  end
end

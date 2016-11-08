class Status < ApplicationRecord

  include Translatable

  default_scope { reorder(:id) }
  scope :active, -> { where(active: true) }

  def to_s
    name
  end
end

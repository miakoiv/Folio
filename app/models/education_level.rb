class EducationLevel < ApplicationRecord

  include Translatable

  default_scope { reorder(:id) }
  scope :needs_info, -> { where(needs_info: true) }

  def to_s
    name
  end
end

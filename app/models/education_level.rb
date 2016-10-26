class EducationLevel < ApplicationRecord

  include Translatable

  default_scope { reorder(:id) }

  def to_s
    name
  end
end

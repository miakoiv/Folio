class EducationLevel < ApplicationRecord

  include Translatable

  default_scope { unscope(:order).order(:id) }

  def to_s
    name
  end
end

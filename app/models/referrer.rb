class Referrer < ApplicationRecord

  include Translatable

  scope :needs_info, -> { where(needs_info: true) }

  def to_s
    name
  end
end

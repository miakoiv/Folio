class Referrer < ApplicationRecord

  include Translatable

  def to_s
    name
  end
end

class Unit < ApplicationRecord

  include Translatable

  has_many :liaisons

  def to_s
    name
  end
end

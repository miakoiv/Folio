class Unit < ApplicationRecord

  include Translatable

  has_many :users
  has_many :liaisons, through: :users

  def to_s
    name
  end
end

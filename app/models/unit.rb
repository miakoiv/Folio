class Unit < ApplicationRecord

  include Translatable

  has_many :users
  has_many :customers


  def self.to_collection_title
    model_name.human(count: 2).capitalize
  end

  def to_s
    name
  end
end

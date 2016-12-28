class Unit < ApplicationRecord

  include Translatable
  resourcify

  has_many :users
  has_many :customers
  has_many :activities

  scope :accessible_by, -> (user) { joins(roles: :users).where(users: {id: user}) }


  def self.to_collection_title
    model_name.human(count: 2).capitalize
  end

  def to_s
    name
  end
end

class MilestoneType < ApplicationRecord

  include Translatable

  has_many :milestones

  def to_s
    name
  end
end

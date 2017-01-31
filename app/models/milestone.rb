class Milestone < ApplicationRecord

  include Translatable

  belongs_to :milestone_type

  def to_s
    name
  end
end

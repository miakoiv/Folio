class Step < ApplicationRecord

  include Trackable

  belongs_to :customer, touch: true
  belongs_to :milestone

  default_scope { order(reached_at: :desc) }

  validates :reached_at, presence: true

  def to_s
    milestone.to_s
  end
end

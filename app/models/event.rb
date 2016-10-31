class Event < ApplicationRecord

  belongs_to :liaison
  belongs_to :event_type


  default_scope { order(starts_at: :desc) }

  # Scope for restricting events to a single user.
  scope :for, -> (user) { where(user: user) }


  validates :title, presence: true

  def to_s
    title
  end
end

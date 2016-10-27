class Event < ApplicationRecord

  belongs_to :event_type
  belongs_to :user
  belongs_to :liaison

  # Scope for restricting events to a single user.
  scope :for, -> (user) { where(user: user) }


  def to_s
    title
  end
end

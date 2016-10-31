class Event < ApplicationRecord

  belongs_to :event_type
  belongs_to :user
  belongs_to :liaison


  default_scope { order(starts_at: :desc)}

  # Scope for restricting events to a single user.
  scope :for, -> (user) { where(user: user) }


  validates :title, presence: true

  def to_s
    title
  end
end

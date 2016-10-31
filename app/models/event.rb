class Event < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :liaison
  belongs_to :event_type

  default_scope { order(starts_at: :desc) }

  validates :title, presence: true

  def to_s
    title
  end
end

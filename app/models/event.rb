class Event < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :liaison
  after_create :touch_liaison

  belongs_to :event_type
  delegate :appearance, to: :event_type

  default_scope { order(starts_at: :desc) }

  validates :title, presence: true

  # An event is considered topical if it belongs to the given liaison.
  def topical?(l)
    liaison == l
  end

  def to_s
    title
  end

  private
    def touch_liaison
      liaison.touch
    end
end

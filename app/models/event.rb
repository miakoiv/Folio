class Event < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :liaison
  after_create :touch_liaison

  belongs_to :event_type
  delegate :appearance, to: :event_type

  default_scope { order(starts_at: :desc) }

  validates :title, presence: true

  before_save :synchronize

  # See app/models/compound_datetime.rb for details.
  attribute :compound_starts_at, :string
  def compound_starts_at
    CompoundDatetime.new(starts_at)
  end
  def compound_starts_at_attributes=(attributes)
    self.starts_at = compound_starts_at.assign_attributes(attributes).datetime
  end


  # An event is considered external if a liaison is specified and
  # the event does not belong to it.
  def external?(for_liaison)
    for_liaison.present? && liaison != for_liaison
  end

  def to_s
    title
  end

  private
    def touch_liaison
      liaison.touch
    end

    def synchronize
      if changes[:ends_at].present?
        # Changing ends_at recalculates duration regardless of starts_at.
        self.duration = ends_at - starts_at
      else
        # In all other cases the new ends_at is calculated from duration.
        self.ends_at = starts_at + duration
      end
    end
end

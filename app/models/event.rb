class Event < ApplicationRecord

  # Events always belong to a user and may belong to a liaison.
  belongs_to :user
  belongs_to :liaison, optional: true

  belongs_to :event_type
  delegate :appearance, to: :event_type

  default_scope { order(starts_at: :desc) }

  validates :title, presence: true

  before_save :synchronize
  after_create :touch_liaison


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

  def context
    liaison || user
  end

  def to_s
    title
  end

  private
    def touch_liaison
      liaison.touch if liaison.present?
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

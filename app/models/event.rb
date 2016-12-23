class Event < ApplicationRecord

  belongs_to :user
  belongs_to :customer, optional: true

  belongs_to :event_type
  delegate :appearance, to: :event_type

  default_scope { order(starts_at: :desc) }
  scope :for, -> (user) { where(user: user) }

  validates :title, presence: true
  validates :duration, presence: true

  before_save :synchronize
  after_create :touch_customer


  # See app/models/compound_datetime.rb for details.
  attribute :compound_starts_at, :string
  def compound_starts_at
    CompoundDatetime.new(starts_at)
  end
  def compound_starts_at_attributes=(attributes)
    self.starts_at = compound_starts_at.assign_attributes(attributes).datetime
  end


  # An event is external when a customer is given as context and this event
  # is not theirs, or without customer context, the event doesn't belong to
  # the given unit.
  def external?(for_customer, at_unit)
    (for_customer.present? && customer != for_customer) || context.unit != at_unit
  end

  def context
    customer || user
  end

  def to_s
    title
  end

  private
    def touch_customer
      customer.touch if customer.present?
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

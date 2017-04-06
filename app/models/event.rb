class Event < ApplicationRecord

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities

  include SoftDeletable
  include Trackable

  belongs_to :unit
  belongs_to :user
  belongs_to :customer, optional: true

  # Event type specifies the event scope, or how to interpret event associations.
  belongs_to :event_type
  delegate :appearance, to: :event_type
  delegate :event_scope, :customer?, :personal?, :shared?, to: :event_type


  default_scope { order(starts_at: :desc) }

  scope :at, -> (unit) { where(unit: unit) }
  scope :for, -> (user) { where(user: user) }

  scope :in_context_of, -> (current_unit, current_user, context) {
    if context.is_a?(Customer)
      where(customer: context).merge(EventType.customer).or(
        where(user: current_user).merge(EventType.customer_or_personal).or(
          where(unit: current_unit).merge(EventType.shared)
        )
      )
    else
      where(user: context).merge(EventType.customer_or_personal).or(
        where(unit: current_unit).merge(EventType.shared)
      )
    end
  }

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


  # Events associated with customers always select from customer event types.
  # Otherwise, new events can be personal or shared, existing events are
  # locked to their existing type.
  def available_event_types
    return EventType.customer if customer.present?
    return EventType.personal_or_shared if new_record?
    [event_type]
  end

  # Event context for activity tracking.
  def context
    return customer if customer?
    return user if personal?
    unit
  end

  def rendering(for_user, for_customer)
    classes = [event_scope]
    classes << appearance if customer?
    classes << 'other-customer' if customer? && for_customer != customer
    classes << 'other-user' if for_user != user
    classes
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

require_dependency 'event/stats'

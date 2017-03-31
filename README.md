# Folio documentation

## Models

### Events

An event has associations to its *event type*, the *unit* it was created at, the *user* who created it, and optionally a *customer*.

    class Event
      belongs_to :event_type
      delegate :event_scope, :customer?, :personal?, :shared?, to: :event_type

      belongs_to :unit
      belongs_to :user
      belongs_to :customer, optional: true
    end

    class EventType
      enum event_scope: {customer: 0, personal: 1, shared: 2}
    end

The event type specifies the *event scope*, or how the event associations are interpreted:

  - **customer** events involve a user and a customer, allocating time from both parties.
  - **personal** events don't involve a customer, the user's own time is allocated.
  - **shared** events don't allocate anyone's time, but they are visible to all users on shared calendars. *The user association is still present to record who created the event.*

With event delegations, there are shortcuts to query the event scope directly:

    @event.customer? || @event.personal?

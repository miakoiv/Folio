module EventsHelper

  def event_type_options
    EventType.all.map { |t| [t.to_s, t.id, data: {label: t.appearance}] }
  end
end

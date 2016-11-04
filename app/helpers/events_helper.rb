module EventsHelper

  def event_type_options
    EventType.all.map { |t| [t.to_s, t.id, data: {label: t.appearance}] }
  end

  def duration_options
    [].tap do |options|
      (1800..14400).step(1800) do |d|
        options << [duration_in_hours_minutes(d), d]
      end
    end
  end

  def duration_in_hours_minutes(secs)
    mins = secs / 60
    return "#{mins}\u2008min" if mins < 60
    h, m = mins.divmod 60
    return "#{h}\u2008h" if m == 0
    "#{h}\u2008h\u2008#{m}\u2008min"
  end
end

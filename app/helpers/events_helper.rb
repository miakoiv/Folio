module EventsHelper

  FRAC = {
    Rational(1,4) => '¼',
    Rational(1,2) => '½',
    Rational(3,4) => '¾',
  }.freeze

  def event_type_options
    EventType.all.map { |t| [t.to_s, t.id, data: {label: t.appearance}] }
  end

  def duration_in_hours(mins)
    h = (mins / 60).to_r
    d = h.denominator
    i = h.to_i
    f = FRAC[h - i]
    return "#{f}\u2008h" if i == 0
    return "#{i}\u2008h" if d == 1
    "#{i}\u2008#{f}\u2008h"
  end

  def duration_in_hours_minutes(mins)
    h = (mins / 60).to_r
    d = h.denominator
    i = h.to_i
    m = ((h - i) * 60).to_i
    return "#{m}\u2008min" if i == 0
    return "#{i}\u2008h" if d == 1
    "#{i}\u2008h\u2008#{m}\u2008min"
  end
end

module CustomersHelper

  def contact_options(unit)
    unit.users.all.map { |u| [u.to_s, u.id] }
  end

  def status_options
    Status.all.map { |s| [s.to_s, s.id, data: {label: s.appearance}] }
  end

  def referrer_options
    Referrer.all.map { |r| [r.to_s, r.id] }
  end
end

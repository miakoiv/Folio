class PolicyAuthorizer < ApplicationAuthorizer

  # Policies may be listed by wizards or admins of their home unit.
  def self.readable_by?(user)
    user.has_role?(:admin, user.unit) ||
    user.has_role?(:wizard, user.unit)
  end

  # Only wizards may create policies.
  def self.creatable_by?(user)
    user.has_role?(:wizard, user.unit)
  end

  # Wizards may edit policies if not mandatory or not accepted yet.
  def updatable_by?(user)
    return false unless user.has_role?(:wizard, user.unit)
    !resource.mandatory? || !resource.accepted?
  end

  # Admins are generally able to accept policies.
  def self.acceptable_by?(user)
    user.has_role?(:admin, user.unit)
  end

  # Admins may accept policies if pending.
  def acceptable_by?(user)
    return false unless user.has_role?(:admin, user.unit)
    resource.pending?
  end
end

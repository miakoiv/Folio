class CustomerAuthorizer < ApplicationAuthorizer

  # Admins and wizards may delete customers in case records
  # are created by mistake and need to be removed.
  def deletable_by?(user)
    user.has_role?(:admin, user.unit) ||
    user.has_role?(:wizard, user.unit)
  end
end

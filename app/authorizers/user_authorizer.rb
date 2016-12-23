class UserAuthorizer < ApplicationAuthorizer

  # Only admins at the current unit may create users.
  def self.creatable_by?(user, options)
    user.has_role?(:admin, options[:unit])
  end

  # Admins may list users. This applies to UserController#index only.
  def self.readable_by?(user, options)
    user.has_role?(:admin, options[:unit])
  end

  # Users can see themselves, admins of a unit and see users at the unit.
  def readable_by?(user)
    user == resource || user.has_role?(:admin, resource.unit)
  end

  # Updating has the same rules as reading.
  def updatable_by?(user)
    user == resource || user.has_role?(:admin, resource.unit)
  end

  # Only admins of the unit are able to delete users.
  def deletable_by?(user)
    user.has_role?(:admin, resource.unit)
  end
end

class PrivilegeAuthorizer < ApplicationAuthorizer

  # Wizards may grant and revoke any role, admins only the user role.
  def creatable_by?(user, options)
    return true if user.has_role?(:wizard, options[:unit])
    return true if user.has_role?(:admin, options[:unit]) && resource.name == 'user'
    false
  end

  def deletable_by?(user, options)
    return true if user.has_role?(:wizard, options[:unit])
    return true if user.has_role?(:admin, options[:unit]) && resource.name == 'user'
    false
  end
end

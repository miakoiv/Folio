class PrivilegeAuthorizer < ApplicationAuthorizer

  def creatable_by?(user, options)
    return false if resource.name == 'admin'
    user.has_role?(:admin, options[:unit])
  end

  def deletable_by?(user, options)
    return false if resource.name == 'admin'
    user.has_role?(:admin, options[:unit])
  end
end

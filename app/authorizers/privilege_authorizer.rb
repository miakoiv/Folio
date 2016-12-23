class PrivilegeAuthorizer < ApplicationAuthorizer

  def updatable_by?(user, options)
    return false if resource.name == 'admin'
    user.has_role?(:admin, options[:unit])
  end
end

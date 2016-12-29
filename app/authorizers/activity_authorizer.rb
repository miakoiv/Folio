class ActivityAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user, options)
    return true if user.has_role?(:wizard, options[:unit])
    return true if user.has_role?(:admin, options[:unit])
    false
  end
end

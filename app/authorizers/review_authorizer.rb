class ReviewAuthorizer < ApplicationAuthorizer

  # Users may view (preview) published reviews in their own unit.
  def readable_by?(user)
    return true if user.has_role?(:admin, resource.customer.unit)
    return true if user.has_role?(:wizard, resource.customer.unit)
    resource.published? && user.has_role?(:user, resource.customer.unit)
  end

  # Users may edit their own unpublished reviews.
  # Admins can edit reviews in their unit, published or not.
  def updatable_by?(user)
    return true if user.has_role?(:admin, resource.customer.unit)
    return true if user.has_role?(:wizard, resource.customer.unit)
    !resource.published? && user == resource.user
  end
end

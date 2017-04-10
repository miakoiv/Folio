class ReviewAuthorizer < ApplicationAuthorizer

  # Users may view (preview) published reviews in their own unit.
  def readable_by?(user)
    resource.published? &&
    user.has_role?(:user, resource.customer.unit) ||
    user.has_role?(:admin, resource.customer.unit) ||
    user.has_role?(:wizard, resource.customer.unit)
  end

  # Users may edit their own unpublished reviews.
  # Admins can edit reviews in their unit, published or not.
  def updatable_by?(user)
    !resource.published? && user == resource.user ||
    user.has_role?(:admin, resource.customer.unit) ||
    user.has_role?(:wizard, resource.customer.unit)
  end
end

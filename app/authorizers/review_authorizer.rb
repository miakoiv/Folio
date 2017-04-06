class ReviewAuthorizer < ApplicationAuthorizer

  # Users may edit their own unpublished reviews.
  # Admins can edit reviews in their unit, published or not.
  def updatable_by?(user)
    !resource.published? && user == resource.user ||
    user.has_role?(:admin, resource.customer.unit) ||
    user.has_role?(:wizard, resource.customer.unit)
  end
end

class PersonAuthorizer < ApplicationAuthorizer

  # Only admins and wizards may download records as XML documents.
  def downloadable_by?(user)
    user.has_role?(:admin, user.unit) ||
    user.has_role?(:wizard, user.unit)
  end
end

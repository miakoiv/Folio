class EventAuthorizer < ApplicationAuthorizer

  # Users may edit their own events. Additionally, customer contacts
  # are allowed to modify events for that customer.
  def updatable_by?(user)
    user == resource.user ||
    resource.customer? && resource.customer.contacts.include?(user)
  end
end

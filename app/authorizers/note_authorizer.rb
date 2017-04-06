class NoteAuthorizer < ApplicationAuthorizer

  # Users may edit their own notes while still fresh.
  def updatable_by?(user)
    resource.fresh? && user == resource.user
  end
end

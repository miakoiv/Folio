# Policies are terms-of-service records that admins may view and accept.
#
class Policy < ApplicationRecord

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities

  include Trackable

  belongs_to :accepted_by, -> { merge(User.including_deleted) },
    class_name: 'User', optional: true

  default_scope { order(created_at: :asc) }
  scope :pending, -> { where(mandatory: true, accepted_at: nil)}


  def pending?
    mandatory? && accepted_at.nil?
  end

  def accepted?
    accepted_at.present?
  end

  def to_s
    title
  end
end

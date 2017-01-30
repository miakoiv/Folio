class Customer < ApplicationRecord

  include Documentable
  include Trackable

  belongs_to :unit
  belongs_to :person
  belongs_to :contact, class_name: 'User', optional: true

  has_many :events, dependent: :destroy
  has_many :notes, dependent: :destroy

  belongs_to :status
  delegate :appearance, :active, to: :status

  belongs_to :referrer, optional: true

  default_scope { order(started_at: :desc) }
  scope :active, -> { joins(:status).merge(Status.active) }

  # Scope for customers at a unit.
  scope :at, -> (unit) { where(unit: unit) }

  # Scope for customers without a contact.
  scope :without_contact, -> { where(contact: nil) }

  # Scope for customers with notes by a user.
  scope :noted_by, -> (user) { joins(:notes).merge(Note.by(user)) }

  def to_s
    "#{model_name.human.capitalize} #{started_at}"
  end
end

require_dependency 'customer/stats'

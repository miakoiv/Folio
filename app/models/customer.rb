class Customer < ApplicationRecord

  include Documentable
  include Trackable

  belongs_to :unit
  belongs_to :person
  has_and_belongs_to_many :contacts, class_name: 'User'

  has_many :events, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :steps, dependent: :destroy

  belongs_to :status
  delegate :appearance, :active, to: :status

  belongs_to :referrer, optional: true

  default_scope { order(started_at: :desc) }
  scope :active, -> { joins(:status).merge(Status.active) }

  # Scope for customers at a unit.
  scope :at, -> (unit) { where(unit: unit) }

  # Scope for customers without a contact.
  scope :without_contact, -> { left_outer_joins(:contacts).where(users: {id: nil}) }

  # Scope for customers with notes by a user.
  scope :noted_by, -> (user) { joins(:notes).merge(Note.by(user)) }


  def contacts_to_s
    contacts.map { |c| "#{c.first_names} #{c.last_name}" }.to_sentence
  end

  def to_s
    "#{model_name.human.capitalize} #{started_at}"
  end
end

require_dependency 'customer/stats'

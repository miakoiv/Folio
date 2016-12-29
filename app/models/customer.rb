class Customer < ApplicationRecord

  include Documentable
  include Trackable

  belongs_to :unit
  belongs_to :person
  has_many :events, dependent: :destroy
  has_many :notes, dependent: :destroy

  belongs_to :status
  delegate :appearance, :active, to: :status

  belongs_to :referrer, optional: true

  default_scope { order(created_at: :desc) }
  scope :active, -> { joins(:status).merge(Status.active) }

  # Scope for customers at a unit.
  scope :at, -> (unit) { where(unit: unit) }

  # Scope for customers with notes by a user.
  scope :noted_by, -> (user) { joins(:notes).merge(Note.by(user)) }

  def date
    created_at.to_date
  end

  def to_s
    "#{model_name.human.capitalize} #{date}"
  end
end

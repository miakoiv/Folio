class Customer < ApplicationRecord

  include Documentable

  belongs_to :creator, class_name: 'User'
  belongs_to :user
  belongs_to :person
  has_many :events, dependent: :destroy
  has_many :notes, dependent: :destroy

  belongs_to :status
  delegate :appearance, :active, to: :status

  belongs_to :referrer, optional: true

  default_scope { order(updated_at: :desc) }
  scope :active, -> { joins(:status).merge(Status.active) }

  # Scope for customers handled by user.
  scope :for, -> (user) { where(user: user) }

  # Scope for finding customers for all users in a unit.
  scope :at, -> (unit) { joins(user: :unit).where(users: {unit_id: unit}) }

  def to_s
    "#{model_name.human.capitalize} / #{person} ↔ #{user}"
  end
end

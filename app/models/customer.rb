class Customer < ApplicationRecord

  include Documentable
  include Trackable

  belongs_to :unit
  belongs_to :person
  belongs_to :contact, class_name: 'User'

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

  def self.count_by_age
    joins(:person).unscope(:order)
      .where.not(people: {date_of_birth: nil})
      .group(Person.age_function.to_sql).count
  end

  def self.count_by_gender
    joins(:person).unscope(:order).group(:gender).count
  end

  def date
    created_at.to_date
  end

  def to_s
    "#{model_name.human.capitalize} #{date}"
  end
end

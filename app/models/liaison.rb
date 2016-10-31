class Liaison < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :user
  belongs_to :person
  has_many :events

  belongs_to :status
  belongs_to :referrer, optional: true

  default_scope { order(created_at: :desc) }

  # Scope for liaisons handled by user.
  scope :for, -> (user) { where(user: user) }

  # Scope for finding liaisons for all users in a unit.
  scope :at, -> (unit) { joins(user: :unit).where(users: {unit_id: unit}) }


  def to_s
    %Q{#{model_name.human.capitalize}
      #{Liaison.human_attribute_name(:created_at).downcase}
      #{created_at.to_date}
      [#{status}]
    }
  end
end

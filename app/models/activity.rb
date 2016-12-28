class Activity < ApplicationRecord

  belongs_to :unit
  belongs_to :user
  belongs_to :resource, polymorphic: true

  serialize :differences, JSON

  default_scope { order(id: :desc) }

end

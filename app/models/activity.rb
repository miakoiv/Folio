# Activities are records of actions taken by users (whodunnit) on
# resources in a certain context. The context may be the resource itself,
# or its relational parent record, with which the activity should appear.
#
class Activity < ApplicationRecord

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities

  belongs_to :unit
  belongs_to :whodunnit, class_name: 'User'
  belongs_to :resource, polymorphic: true
  belongs_to :context, polymorphic: true

  serialize :differences, JSON

  default_scope { order(id: :desc) }
  scope :at, -> (unit) { where(unit: unit) }


  ACTIONS = {
       show: {icon: 'info-circle', appearance: 'info'},
       edit: {icon: 'pencil-square', appearance: 'info'},
     create: {icon: 'plus-circle', appearance: 'success'},
     update: {icon: 'pencil-square', appearance: 'success'},
    destroy: {icon: 'minus-circle', appearance: 'warning'}
  }.freeze

  def icon
    Activity::ACTIONS[action.to_sym][:icon]
  end

  def appearance
    Activity::ACTIONS[action.to_sym][:appearance]
  end

  def to_s
    "#{model_name.human.capitalize} #{created_at.year}-#{id}"
  end
end

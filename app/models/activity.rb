class Activity < ApplicationRecord

  belongs_to :unit
  belongs_to :user
  belongs_to :resource, polymorphic: true

  serialize :differences, JSON

  default_scope { order(id: :desc) }


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
    action
  end
end

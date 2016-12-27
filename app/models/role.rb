class Role < ApplicationRecord

  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource, polymorphic: true, optional: true

  default_scope { order(:name, :resource_type, :resource_id) }

  validates :resource_type,
    inclusion: {in: Rolify.resource_types},
    allow_nil: true

  scopify


  ALL = {
      user: {icon: 'user', appearance: 'blue'},
     admin: {icon: 'user-circle-o', appearance: 'violet'},
    wizard: {icon: 'magic', appearance: 'red-deep'}
  }.freeze

  def self.resource_classes
    [Unit]
  end

  def resource_gid
    resource.to_global_id
  end

  def icon
    Role::ALL[name.to_sym][:icon]
  end

  def appearance
    Role::ALL[name.to_sym][:appearance]
  end

  def to_s
    name
  end
end

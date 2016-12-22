class Role < ApplicationRecord

  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource, polymorphic: true, optional: true

  validates :resource_type,
    inclusion: {in: Rolify.resource_types},
    allow_nil: true

  scopify

  def resource_gid
    resource.to_global_id
  end

  def to_s
    name.capitalize
  end
end

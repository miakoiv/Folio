#
# Privileges are non-database backed objects that, when created and destroyed,
# actually add or remove user roles specified by its attributes.
#
class Privilege
  extend ActiveModel::Naming

  include ActiveModel::Model
  attr_accessor :name, :resource_gid


  # Returns the resource this privilege specifies with its resource gid.
  def resource
    GlobalID::Locator.locate(resource_gid)
  end
end
